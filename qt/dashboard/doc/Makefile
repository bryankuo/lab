TARGET          := $(shell uname -r)

KERNEL_MODULES  := /lib/modules/$(TARGET)
KERNEL_BUILD    := $(KERNEL_MODULES)/build
SYSTEM_MAP      := $(shell if test -r /boot/System.map-$(TARGET) ; then echo /boot/System.map-$(TARGET) ; else echo $(KERNEL_BUILD)/System.map ; fi)

DRIVER := NEXCOM_CAN1
obj-m := $(DRIVER).o

# Directory below /lib/modules/$(TARGET)/kernel into which to install
# the module:
MOD_SUBDIR = drivers/char
MAKEFLAGS       += --no-print-directory
EXTRA_CFLAGS    += -DDEBUG

modules_install:
	test -d $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR) || mkdir $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	cp $(DRIVER).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	depmod -a -F $(SYSTEM_MAP) $(TARGET)
