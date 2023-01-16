# nicekernel
A basic kernel written in C!

## Prerequisites

Ensure that the following tools are installed:

- binutils
- gcc
- grub-common
- make
- nasm
- xorriso

## Use

While in the `nicekernel` directory, compile the kernel and create the ISO file using the makefile:

```bash
$ make
```

The ISO file is found at `build/nicekernel.iso`.

If you want, you can delete all of the build files (and the ISO file) with the makefile as well:

```bash
$ make clean
```

Now that you have the ISO file, you can boot it on a real computer using a CD or thumb drive, or on a virtual machine.

## Attribution

The initial infrastructure for the kernel was copied almost entirely from [this Linux Journal article](https://www.linuxjournal.com/content/what-does-it-take-make-kernel-0).