import std/[os]
import device_id/common

when defined(macosx):
  {.passL: "-framework CoreFoundation -framework IOKit".}
  {.compile: currentSourcePath.parentDir / "device_id" / "macosx.c".}
  proc get_platform_uuid(s: cstring): int {.importc: "get_platform_uuid".}
  proc getPlatformUUID*(): string =
    result = newString(36)
    discard get_platform_uuid(result.cstring)

when isMainModule:
  echo getPlatformUUID()
