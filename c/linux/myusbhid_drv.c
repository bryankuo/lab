#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/usb.h>

static int mmod_probe(struct usb_interface *intf,
                      const struct usb_device_id *id)
{
        pr_debug("mmod: probe is called");

        /* return -ENODEV if we don't want to claim the device */
        return 0;
}

static void mmod_disc(struct usb_interface *intf)
{
        pr_debug("mmod: disconnected");
}

static const struct usb_device_id mmod_id[] = {
        {.match_flags = USB_DEVICE_ID_MATCH_INT_PROTOCOL,
         .bInterfaceClass = 0x01
        },
        {}
};

/* export the id to userspace */
MODULE_DEVICE_TABLE(usb, mmod_id);

static struct usb_driver mmod_driver = {
        .name = "mmod_driver",
        .id_table = mmod_id,
        .probe = mmod_probe,
        .disconnect = mmod_disc
};

static int __init init_task05(void)
{
        pr_debug("mmod loaded");
        usb_register(&mmod_driver);

        return 0;
}

static void __exit exit_mymod(void)
{
        pr_debug("mmod unloaded");
        usb_deregister(&mmod_driver);
}

module_init(init_mmod);
module_exit(exit_mmod);

MODULE_LICENSE("GPL");
