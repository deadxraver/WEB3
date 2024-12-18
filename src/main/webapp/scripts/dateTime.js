const div = document.getElementById('date-time-div');

function printDate() {
	const date = new Date();
	div.innerText = date.toLocaleDateString('ru-RU') + ' ' + date.toLocaleTimeString('ru-RU');
}

printDate();

setInterval(printDate, 12000);
