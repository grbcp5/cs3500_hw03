default:
	rm reportsAll.txt
	tester.sh
	cat reports/* > reportsAll.txt
