# Sadri - May - 13 - 2015 - Updated! 

# This simple tcl script performs a test on the operation of axi dma in sg mode 

# Author : Mohammad S. Sadri 

# This script is provided for educational purposes only 
# For commercial use please contact the author directly at mamsadegh@green-electrons.com


####################################
#
# Init xmd and program PL
#
####################################
connect arm hw

fpga -f ../vivado_zed/project_1/project_1.runs/impl_1/design_1_wrapper.bit

source ../vivado_zed/project_1/project_1.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl

ps7_init
ps7_post_config 

####################################
#
# Constants 
#
####################################
set transferSize [expr 60]
set transferSize_1 32 
set transferSize_2 28
set numberOfPackets 2 
set transferWords [expr $transferSize/4+3]

####################################
#
# Reset DMA and Init
#
####################################
# configure MM2S 
# we want cyclic bd to be active
# reset MM2S
mwr 0x40400000 0x0001dff6
mwr 0x40400000 0x0001dff2

# configure S2MM
# Reset S2MM
mwr 0x40400030 0x0001dff6
mwr 0x40400030 0x0001dff2 

####################################
#
# Write Descriptors - mm2s 
#
####################################
# 4 descriptors total. 2 descriptors per packet. descriptor 1 transfers 32 bytes. descritor 2 transfers the rest of 28 bytes. 
# source addresses : 0x00a00000 and 0x00c00000 

mwr 0x40000000 0x40000040
mwr 0x40000004 0x00000000 
mwr 0x40000008 0x00a00000
mwr 0x4000000c 0x00000000
mwr 0x40000010 0x00000000
mwr 0x40000014 0x00000000
mwr 0x40000018 [expr 0x08000000+$transferSize_1]
mwr 0x4000001c 0x00000000 
mwr 0x40000020 0x00000000
mwr 0x40000024 0x00000000
mwr 0x40000028 0x00000000
mwr 0x4000002c 0x00000000
mwr 0x40000030 0x00000000

mwr 0x40000040 0x40000080
mwr 0x40000044 0x00000000 
mwr 0x40000048 0x00a00020
mwr 0x4000004c 0x00000000
mwr 0x40000050 0x00000000
mwr 0x40000054 0x00000000
mwr 0x40000058 [expr 0x04000000+$transferSize_2]
mwr 0x4000005c 0x00000000 
mwr 0x40000060 0x00000000
mwr 0x40000064 0x00000000
mwr 0x40000068 0x00000000
mwr 0x4000006c 0x00000000
mwr 0x40000070 0x00000000

mwr 0x40000080 0x400000C0
mwr 0x40000084 0x00000000 
mwr 0x40000088 0x00c00000
mwr 0x4000008c 0x00000000
mwr 0x40000090 0x00000000
mwr 0x40000094 0x00000000
mwr 0x40000098 [expr 0x08000000+$transferSize_1]
mwr 0x4000009c 0x00000000 
mwr 0x400000a0 0x00000000
mwr 0x400000a4 0x00000000
mwr 0x400000a8 0x00000000
mwr 0x400000ac 0x00000000
mwr 0x400000b0 0x00000000

mwr 0x400000c0 0x40000000
mwr 0x400000c4 0x00000000 
mwr 0x400000c8 0x00c00020
mwr 0x400000cc 0x00000000
mwr 0x400000d0 0x00000000
mwr 0x400000d4 0x00000000
mwr 0x400000d8 [expr 0x04000000+$transferSize_2]
mwr 0x400000dc 0x00000000 
mwr 0x400000e0 0x00000000
mwr 0x400000e4 0x00000000
mwr 0x400000e8 0x00000000
mwr 0x400000ec 0x00000000
mwr 0x400000f0 0x00000000

####################################
#
# Write Descriptors - s2mm 
#
####################################
# s2mm descriptors 
# two descriptor per packet
# first one transfers 32 bytes and second one transfers 28 bytes. destination addresses are 0x00b00000 and 0x00d00000

mwr 0x40001000 0x40001040
mwr 0x40001004 0x00000000 
mwr 0x40001008 0x00b00000
mwr 0x4000100c 0x00000000
mwr 0x40001010 0x00000000
mwr 0x40001014 0x00000000
mwr 0x40001018 [expr 0x08000000+$transferSize_1]
mwr 0x4000101c 0x00000000 
mwr 0x40001020 0x00000000
mwr 0x40001024 0x00000000
mwr 0x40001028 0x00000000
mwr 0x4000102c 0x00000000
mwr 0x40001030 0x00000000

mwr 0x40001040 0x40001080
mwr 0x40001044 0x00000000 
mwr 0x40001048 0x00b00020
mwr 0x4000104c 0x00000000
mwr 0x40001050 0x00000000
mwr 0x40001054 0x00000000
mwr 0x40001058 [expr 0x04000000+$transferSize_2]
mwr 0x4000105c 0x00000000 
mwr 0x40001060 0x00000000
mwr 0x40001064 0x00000000
mwr 0x40001068 0x00000000
mwr 0x4000106c 0x00000000
mwr 0x40001070 0x00000000

mwr 0x40001080 0x400010c0
mwr 0x40001084 0x00000000 
mwr 0x40001088 0x00d00000
mwr 0x4000108c 0x00000000
mwr 0x40001090 0x00000000
mwr 0x40001094 0x00000000
mwr 0x40001098 [expr 0x08000000+$transferSize_1]
mwr 0x4000109c 0x00000000 
mwr 0x400010a0 0x00000000
mwr 0x400010a4 0x00000000
mwr 0x400010a8 0x00000000
mwr 0x400010ac 0x00000000
mwr 0x400010b0 0x00000000

mwr 0x400010c0 0x40001000
mwr 0x400010c4 0x00000000 
mwr 0x400010c8 0x00d00020
mwr 0x400010cc 0x00000000
mwr 0x400010d0 0x00000000
mwr 0x400010d4 0x00000000
mwr 0x400010d8 [expr 0x04000000+$transferSize_1]
mwr 0x400010dc 0x00000000 
mwr 0x400010e0 0x00000000
mwr 0x400010e4 0x00000000
mwr 0x400010e8 0x00000000
mwr 0x400010ec 0x00000000
mwr 0x400010f0 0x00000000

####################################
#
# Initialize DRAM 
#
####################################
# initialize memory which is read by mm2s
for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00a00000+$i*4] [expr 0xa0000000+$i]
}

for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00c00000+$i*4] [expr 0xc0000000+$i]
}

# initializing memory which is being written to by s2mm 
for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00b00000+$i*4] 0xbbbbbbbb
}

for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00d00000+$i*4] 0xdddddddd
}

####################################
#
# start S2MM
#
####################################
# for s2mm write the current descriptor pointer 
mwr 0x4040003c 0x00000000
mwr 0x40400038 0x40001000

# start s2mm engine 
mwr 0x40400030 0x0001dff3

# for s2mm write tail descriptor pointer 
mwr 0x40400044 0x00000000
mwr 0x40400040 0x40001100 

####################################
#
# Start MM2S
#
####################################
# for mm2s write the value of current descriptor and tail descriptor 
mwr 0x4040000c 0x00000000
mwr 0x40400008 0x40000000

# enable mm2s
mwr 0x40400000 0x0001dff3

# # mm2s tail desc pointer. write msb first. 
mwr 0x40400014 0x00000000
mwr 0x40400010 0x40000100

####################################
#
# Start Packet Generator
#
####################################
# now start the sample generator 
mwr 0x43c00004 $transferSize 
mwr 0x43c00000 0x01 

# wait for a short while 
exec sleep 1

####################################
#
# Results
#
####################################

puts "########## Results ############"

puts "DMA Status:"
puts [mrd 0x40400004]
puts [mrd 0x40400034]

puts "Sample generator s axis interface:"
puts [mrd 0x43c00010]
puts [mrd 0x43c00014]
puts [mrd 0x43c00018]
puts [mrd 0x43c0001c]

