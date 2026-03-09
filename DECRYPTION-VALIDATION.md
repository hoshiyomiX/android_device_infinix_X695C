# FBE Decryption Validation Report
## Infinix X695C - MediaTek MT6785 (Helio G95)

---

## 📋 Encryption Configuration (from fstab.mt6785)

```
/dev/block/platform/bootdevice/by-name/userdata /data f2fs noatime,nosuid,nodev,discard,noflush_merge,reserve_root=134217,resgid=1065,tran_gc,inlinecrypt wait,check,formattable,quota,latemount,resize,reservedsize=128m,checkpoint=fs,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized,keydirectory=/metadata/vold/metadata_encryption,fsverity
```

### Encryption Type
| Property | Value |
|----------|-------|
| **Type** | FBE (File-Based Encryption) |
| **Algorithm** | aes-256-xts:aes-256-cts |
| **Version** | fscrypt v2 |
| **Inline Crypt** | Yes (inlinecrypt_optimized) |
| **Metadata Encryption** | /metadata/vold/metadata_encryption |

---

## 🔐 Keymaster Configuration

### Service (from RC file)
```
service vendor.keymaster-4-0-beanpod /vendor/bin/hw/android.hardware.keymaster@4.0-service.beanpod
    class early_hal
    user system
    group system drmrpc
```

### Keymaster Version
- **Version**: 4.0
- **Implementation**: Beanpod (MediaTek TEE)
- **TEE**: MediaTek Beanpod

---

## 🗂️ Required Decryption Blobs

### Keymaster Libraries (lib64/)
| File | Size | Purpose | Status |
|------|------|---------|--------|
| libkeymaster4.so | 87.6 KB | Keymaster 4.0 core | ✅ Present |
| libkeymaster4support.so | 99.2 KB | Keymaster 4.0 support | ✅ Present |
| libkeymaster_messages.so | 98.2 KB | Keymaster messaging | ✅ Present |
| libkeymaster_portable.so | 343 KB | Portable keymaster | ✅ Present |
| libpuresoftkeymasterdevice.so | 47 KB | Software keymaster device | ✅ Present |

### Keymaster Attestation (MediaTek)
| File | Size | Purpose | Status |
|------|------|---------|--------|
| vendor.mediatek.hardware.keymaster_attestation@1.0.so | 72 KB | Attestation HAL 1.0 | ✅ Present |
| vendor.mediatek.hardware.keymaster_attestation@1.1.so | 81 KB | Attestation HAL 1.1 | ✅ Present |
| vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so | 21 KB | Attestation impl | ✅ Present |

### Gatekeeper HAL (lib64/hw/)
| File | Size | Purpose | Status |
|------|------|---------|--------|
| android.hardware.gatekeeper@1.0-impl.so | 16.5 KB | Gatekeeper HAL impl | ✅ Present |
| gatekeeper.beanpod.so | 16 KB | MediaTek TEE gatekeeper | ✅ Present |
| kmsetkey.beanpod.so | 16.5 KB | Keymaster set key | ✅ Present |

### Service Binaries (bin/hw/)
| File | Size | Purpose | Status |
|------|------|---------|--------|
| android.hardware.keymaster@4.0-service.beanpod | 53 KB | Keymaster service | ✅ Present |
| android.hardware.gatekeeper@1.0-service | 11.7 KB | Gatekeeper service | ✅ Present |

### HIDL Libraries
| File | Size | Purpose | Status |
|------|------|---------|--------|
| libhwbinder.so | 10.8 KB | HwBinder support | ✅ Present |
| libhidltransport.so | 10.8 KB | HIDL transport | ✅ Present |

---

## 📁 Service RC Files

### android.hardware.keymaster@4.0-service.beanpod.rc
```
service vendor.keymaster-4-0-beanpod /vendor/bin/hw/android.hardware.keymaster@4.0-service.beanpod
    class early_hal
    user system
    group system drmrpc
```

### android.hardware.gatekeeper@1.0-service.rc
```
service vendor.gatekeeper-1-0 /vendor/bin/hw/android.hardware.gatekeeper@1.0-service
    interface android.hardware.gatekeeper@1.0::IGatekeeper default
    class hal
    user system
    group system
```

---

## ⚙️ BoardConfig.mk Crypto Flags

```makefile
# CRYPTO (File-Based Encryption)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
TW_PREPARE_DATA_MEDIA_EARLY := true
```

---

## 📝 device.mk Crypto Modules

```makefile
# Additional libraries for FBE crypto
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster4support \
    libkeymaster_messages \
    libkeymaster_portable \
    libpuresoftkeymasterdevice \
    libhwbinder \
    libhidltransport
```

---

## ✅ Validation Checklist

| Check | Status | Notes |
|-------|--------|-------|
| FBE v2 encryption identified | ✅ | fscrypt v2 with aes-256-xts |
| Keymaster 4.0 blobs present | ✅ | All 5 libraries present |
| Gatekeeper 1.0 blobs present | ✅ | HAL + Beanpod TEE |
| Keymaster service binary | ✅ | beanpod service |
| Gatekeeper service binary | ✅ | Standard service |
| Keymaster attestation blobs | ✅ | MediaTek attestation HAL |
| Service RC files created | ✅ | Both RC files present |
| BoardConfig crypto flags | ✅ | FBE flags configured |
| Recovery init RC | ✅ | Services will start |
| kmsetkey.beanpod.so | ✅ | Key set functionality |

---

## 🔧 Decryption Flow

1. **Recovery starts** → init parses `init.recovery.mt6785.rc`
2. **Keymaster service starts** → `android.hardware.keymaster@4.0-service.beanpod`
3. **Gatekeeper service starts** → `android.hardware.gatekeeper@1.0-service`
4. **TWRP requests decryption** → Uses keymaster to derive keys
5. **Beanpod TEE** → Handles secure key operations
6. **Data partition decrypted** → User can access /data

---

## 📊 Total Decryption Blobs

| Category | Count | Total Size |
|----------|-------|------------|
| Keymaster libraries | 5 | ~675 KB |
| Attestation libraries | 3 | ~174 KB |
| Gatekeeper HAL | 3 | ~49 KB |
| Service binaries | 2 | ~65 KB |
| HIDL libraries | 2 | ~22 KB |
| RC files | 2 | <1 KB |
| **Total** | **17** | **~985 KB** |

---

## ⚠️ Important Notes

1. **Beanpod TEE**: This device uses MediaTek's Beanpod TEE (Trusted Execution Environment) for secure key storage. The `gatekeeper.beanpod.so` and `kmsetkey.beanpod.so` are critical for TEE communication.

2. **Keymaster 4.0**: Android 11 uses Keymaster 4.0 which supports fscrypt v2. Make sure all keymaster libraries are properly loaded.

3. **Early HAL**: The keymaster service starts as `early_hal` class, which means it starts before other HALs. This is important for decryption to work early in the boot process.

4. **Anti-rollback**: The BoardConfig.mk includes anti-rollback bypass patches which prevent security patch version mismatches from blocking decryption.

---

## 🎯 Decryption Status: ✅ READY

All required blobs and configurations are in place for FBE decryption on this device.
