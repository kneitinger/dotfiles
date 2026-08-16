#!/usr/bin/env bash

args=('--force' '--no-hostonly-cmdline')

for k in /usr/lib/modules/*; do
	kver="$(echo "$k" | cut -d'/' -f5)"
	pkgbase=$(cat "$k"/pkgbase)

	install -Dm0644 "$k/vmlinuz" "/boot/vmlinuz-${pkgbase}"
	dracut "${args[@]}" --hostonly "/boot/initramfs-${pkgbase}.img" --kver "$kver"
	#dracut "${args[@]}" --add-confdir rescue  "/boot/initramfs-${pkgbase}-fallback.img" --kver "$kver"
done
