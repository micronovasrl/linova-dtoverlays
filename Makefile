GCC?=gcc
DTC?=$(KDIR)/scripts/dtc/dtc
DTC_OPTIONS?=-@ -i $(KDIR)/arch/arm/boot/dts

OBJECTS:= $(patsubst %.dts,%.dtbo,$(wildcard *.dts))

%.pre.dts: %.dts
	$(GCC) -E -nostdinc -I$(KDIR)/include -I$(KDIR)/arch/arm/boot/dts -x assembler-with-cpp -undef -o $@ $^

%.dtbo: %.pre.dts
	$(DTC) $(DTC_OPTIONS) -I dts -O dtb -o $@ $^

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)
