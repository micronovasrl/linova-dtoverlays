KDIR=/home/giuliobenetti/git/github/micronovasrl/linova-linux

GCC?=gcc
DTC?=$(KDIR)/scripts/dtc/dtc
DTC_OPTIONS?=-@ -W no-unit_address_vs_reg

OBJECTS:= $(patsubst %.dtso,%.dtbo,$(wildcard *.dtso))
OBJECTS+= $(patsubst %.dts,%.dtb,$(wildcard *.dts))

%.pre.dtso: %.dtso
	$(GCC) -E -nostdinc -I$(KDIR)/include -x assembler-with-cpp -undef -o $@ $^

%.dtbo: %.pre.dtso
	$(DTC) $(DTC_OPTIONS) -I dts -O dtb -o $@ $^

%.pre.dts: %.dts
	$(GCC) -E -nostdinc -I$(KDIR)/include -I$(KDIR)/arch/arm/boot/dts -x assembler-with-cpp -undef -o $@ $^

%.dtb: %.pre.dts
	$(DTC) $(DTC_OPTIONS) -I dts -O dtb -o $@ $^

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)
