# Simple boot sector that attempts to boot a C kernel in 32-bit pm

## Usage

1. Complie kernel

    ```
    gcc -ffreestanding -c kernel.c -o kernel.o
    ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
    ```

2. Compile boot sector image

    ```
    nasm kernel_loader.asm -f bin -o boot_sect.bin
    ```

3. Concatenate boot sector and kernel into a kernel image

    ```
    cat boot_sect.bin kernel.bin > kernel-image
    ```

4. Install&configure bochs (this can be done in qemu, but I'm using bochs as it gives more verbose debug info)

    ```
    sudo apt-get install bochs && sudo apt-get install bochs-x
    echo -e 'floppya: 1_44=os-image , status=inserted\nboot: a' >> bochsrc  #ignore if using the config given in this repo
    ```

5. Start bochs

    ```
    bochs
    ```
