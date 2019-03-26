include ttbox/project.mk

GENERATED_PAGES=$(shell find images -name '*.png' ! -name 'template.png' | cut -f 2 -d / | cut -f 1 -d .)
GENERATED_PAGES_SVGS=$(GENERATED_PAGES:%=%-generated.svg)
GENERATED_PAGES_WITH_OIDS_SVGS=$(GENERATED_PAGES:%=%-with-oids.svg)

all:: $(GENERATED_PAGES_WITH_OIDS_SVGS)

clean::
	rm -f $(GENERATED_PAGES_SVGS) $(GENERATED_PAGES_WITH_OIDS_SVGS)

$(GENERATED_PAGES_SVGS): template.svg
	sed \
		-e "s/template/$(shell basename "$@" -generated.svg)/g" \
		-e "s/-only-on-$(shell basename "$@" -generated.svg)\()\)/\1/" \
		-e "s/([a-zA-Z0-9_-]*-not-on-$(shell basename "$@" -generated.svg)\()\)//" \
		-e "s/-not-on-[a-zA-Z0-9_-]*\()\)/\1/" \
		$< >$@

template-with-oids.svg:
	@:
