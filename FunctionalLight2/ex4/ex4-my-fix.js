function lotteryNum() {
	return (Math.round(Math.random() * 100) % 58) + 1;
}

function pickNumber(currentNumbers){ // [1,2,3]
	var newArray = [];
	var sortedArray = []
	currentNumbers.forEach(function(value) {
		newArray.push(value);
	})
	var newNumber = lotteryNum();
	while (newArray.indexOf(newNumber) !== -1) {
		newNumber = lotteryNum();
	}

	newArray.push(newNumber);
	sortedArray = newArray.sort(function(a, b) {
		return a - b;
	});

	console.log("newArray", newArray)
	console.log("currentNumbers", currentNumbers)
	console.log("sortedArray", sortedArray)

	return sortedArray
}

var luckyLotteryNumbers = [];

for (var i = 0; i < 6; i++) {
	luckyLotteryNumbers = pickNumber(luckyLotteryNumbers);
}

console.log(luckyLotteryNumbers); // [3,5,6,17,28,40]

// 1. create
// 2. push in numbers, but keep sorted
// 3. pure - no side effects on other array