#!/usr/bin/env swift

import CoreAudio
import Foundation

let systemObject = AudioObjectID(kAudioObjectSystemObject)

func propertySize(_ object: AudioObjectID, _ selector: AudioObjectPropertySelector, _ scope: AudioObjectPropertyScope) -> UInt32? {
  var address = AudioObjectPropertyAddress(
    mSelector: selector,
    mScope: scope,
    mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMain)
  )
  var size: UInt32 = 0
  let status = AudioObjectGetPropertyDataSize(object, &address, 0, nil, &size)
  return status == noErr ? size : nil
}

func stringProperty(_ object: AudioObjectID, _ selector: AudioObjectPropertySelector) -> String {
  var address = AudioObjectPropertyAddress(
    mSelector: selector,
    mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
    mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMain)
  )
  var value: CFString = "" as CFString
  var size = UInt32(MemoryLayout<CFString>.size)
  let status = AudioObjectGetPropertyData(object, &address, 0, nil, &size, &value)
  return status == noErr ? value as String : ""
}

func allDevices() -> [AudioDeviceID] {
  guard var size = propertySize(systemObject, kAudioHardwarePropertyDevices, AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal)) else {
    return []
  }
  let count = Int(size) / MemoryLayout<AudioDeviceID>.size
  var devices = [AudioDeviceID](repeating: 0, count: count)
  var address = AudioObjectPropertyAddress(
    mSelector: kAudioHardwarePropertyDevices,
    mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
    mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMain)
  )
  let status = AudioObjectGetPropertyData(systemObject, &address, 0, nil, &size, &devices)
  return status == noErr ? devices : []
}

func hasStreams(_ device: AudioDeviceID, _ scope: AudioObjectPropertyScope) -> Bool {
  guard let size = propertySize(device, kAudioDevicePropertyStreams, scope) else {
    return false
  }
  return size > 0
}

func defaultDevice(_ selector: AudioObjectPropertySelector) -> AudioDeviceID? {
  var address = AudioObjectPropertyAddress(
    mSelector: selector,
    mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
    mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMain)
  )
  var device = AudioDeviceID(0)
  var size = UInt32(MemoryLayout<AudioDeviceID>.size)
  let status = AudioObjectGetPropertyData(systemObject, &address, 0, nil, &size, &device)
  return status == noErr ? device : nil
}

func setDefaultDevice(_ uid: String, _ selector: AudioObjectPropertySelector) -> Bool {
  guard let device = allDevices().first(where: { stringProperty($0, kAudioDevicePropertyDeviceUID) == uid }) else {
    return false
  }
  var target = device
  var address = AudioObjectPropertyAddress(
    mSelector: selector,
    mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
    mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMain)
  )
  let size = UInt32(MemoryLayout<AudioDeviceID>.size)
  return AudioObjectSetPropertyData(systemObject, &address, 0, nil, size, &target) == noErr
}

func printDevices(_ direction: String) {
  let scope = direction == "input"
    ? AudioObjectPropertyScope(kAudioObjectPropertyScopeInput)
    : AudioObjectPropertyScope(kAudioObjectPropertyScopeOutput)
  let defaultSelector = direction == "input"
    ? kAudioHardwarePropertyDefaultInputDevice
    : kAudioHardwarePropertyDefaultOutputDevice
  let current = defaultDevice(defaultSelector)

  for device in allDevices().filter({ hasStreams($0, scope) }) {
    let marker = device == current ? "*" : "-"
    let name = stringProperty(device, kAudioObjectPropertyName)
    let uid = stringProperty(device, kAudioDevicePropertyDeviceUID)
    if !name.isEmpty && !uid.isEmpty {
      print("\(marker)\t\(uid)\t\(name)")
    }
  }
}

let args = CommandLine.arguments
guard args.count >= 3 else {
  fputs("usage: audio_devices.swift list input|output | set input|output uid\n", stderr)
  exit(2)
}

switch (args[1], args[2]) {
case ("list", "input"), ("list", "output"):
  printDevices(args[2])
case ("set", "input"):
  exit(args.count >= 4 && setDefaultDevice(args[3], kAudioHardwarePropertyDefaultInputDevice) ? 0 : 1)
case ("set", "output"):
  let ok = args.count >= 4
    && setDefaultDevice(args[3], kAudioHardwarePropertyDefaultOutputDevice)
    && setDefaultDevice(args[3], kAudioHardwarePropertyDefaultSystemOutputDevice)
  exit(ok ? 0 : 1)
default:
  fputs("usage: audio_devices.swift list input|output | set input|output uid\n", stderr)
  exit(2)
}
