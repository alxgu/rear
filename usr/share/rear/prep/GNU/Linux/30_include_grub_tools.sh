# GRUB2 has much more commands then the legacy grub command, including modules
# check if we're using grub2 before doing something...
[ ! -d $VAR_LIB/recovery ] && mkdir -p $VAR_DIR/recovery
if has_binary grub-probe; then
	grub-probe -t device /boot/grub > $VAR_DIR/recovery/bootdisk 2>/dev/null || return
elif has_binary grub2-probe; then
	grub2-probe -t device /boot/grub >$VAR_DIR/recovery/bootdisk 2>/dev/null || return
fi

PROGS=( "${PROGS[@]}"
grub-install grub-mkdevicemap grub-probe grub-set-default grub-mkconfig grub-reboot grub-setup grub-mkimage grub-mkrelpath
grub2-install grub2-mkdevicemap grub2-probe grub2-set-default grub2-mkconfig grub2-reboot grub2-setup grub2-mkimage grub2-mkrelpath
)

COPY_AS_IS=( "${COPY_AS_IS[@]}" /etc/default/grub /etc/grub.d/* /etc/grub*.cfg /boot/grub* /usr/lib/grub* )
