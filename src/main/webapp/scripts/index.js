function handleRChange() {
	console.log(ice.ace.instance("frm:r").getValue() / 4);
	window.canvasDrawer.redrawAll(ice.ace.instance("frm:r").getValue() / 4);
}

document.addEventListener("DOMContentLoaded", () => {
	window.canvasDrawer = new CanvasDrawer();
	window.canvasDrawer.redrawAll(ice.ace.instance("frm:r").getValue() / 4);

});