default:
	touch reportsAll.txt
	rm reportsAll.txt
	tester.sh
	cat reports/* > reportsAll.txt
