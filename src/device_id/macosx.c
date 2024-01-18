#include <stdio.h>
#include <stdlib.h>
#include <IOKit/IOKitLib.h>
// #if (MAC_OS_X_VERSION_MAX_ALLOWED < 120000) // Before macOS 12 Monterey
//   #define kIOMainPortDefault kIOMasterPortDefault
// #endif

int get_platform_uuid(char s[36])
{
    io_service_t platformExpert = IOServiceGetMatchingService(0, IOServiceMatching("IOPlatformExpertDevice"));

    CFStringRef uuid = (CFStringRef)IORegistryEntryCreateCFProperty(platformExpert, CFSTR("IOPlatformUUID"), kCFAllocatorDefault, 0);
    const char *uuidString = CFStringGetCStringPtr(uuid, kCFStringEncodingUTF8);
    // printf("Device Unique ID: %s\n", s);
    strcpy(s, uuidString);

    CFRelease(uuid);
    IOObjectRelease(platformExpert);

    return 0;
}