#OS From Scratch

##Usage

Currently the directories contain boot sector programs written in x86 assembly. To run these, 

1. install qemu

    ```
    sudo apt-get install qemu	#or your distro's equivalent
    
    alias qemu='qemu-system-i386'	#for ease of use
    ```

2. install nasm

    ```
    sudo apt-get install nasm
    ```

3. enter the directory of the program you want to run, compile it with nasm, and run it with qemu

    ```
    cd hello_world

    nasm boot_sect_hello_world.asm -f bin -o boot_sect.bin	#compile

    qemu boot_sect.bin						#run
    ```



