all: fullLabNB.pdf

today:
	bin/today.sh

commitToday:
	bin/commitToday.sh

fullLabNB.pdf: FORCE
	$(MAKE) -C build fullLabNB.pdf
	cp build/fullLabNB.pdf fullLabNB.pdf

FORCE:
