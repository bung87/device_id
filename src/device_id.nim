when defined(macosx):
  import std/[os]
  {.passL: "-framework CoreFoundation -framework IOKit".}
  {.compile: currentSourcePath.parentDir / "device_id" / "macosx.c".}

  proc get_platform_uuid(s: cstring): int {.importc: "get_platform_uuid".}
  proc getPlatformUUID*(): string =
    result = newString(36)
    discard get_platform_uuid(result.cstring)

elif defined(windows):
  import device_id/win
  export win

elif defined(linux):
  import std/[os, strutils]

  proc getMachineId*(): string =
    result = readFile("/etc/machine-id").strip()

proc getDeviceId*: string =
  when defined(windows):
    return geMachineGUIDFromRegistry()
  elif defined(linux):
    return getMachineId()
  elif defined(macosx):
    return getPlatformUUID()

when isMainModule:
  when defined(macosx):
    echo getPlatformUUID()
  elif defined(windows):
    echo getProductUUIDFromShell()
  elif defined(linux):
    echo getMachineId()
