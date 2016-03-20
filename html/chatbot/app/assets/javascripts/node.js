function updateNodeSearch(){
	var nodeInput = document.getElementById('node_search_text');
	var nodeText = nodeInput.value;
	var oDiv = document.getElementById('node_search_options');
	
	if (nodeText != ''){
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "get_nodes/" + encodeURIComponent(nodeText), true);
		xhttp.send();
		
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				var responseHtml = xhttp.responseText;
				responseHtml = responseHtml.substring(responseHtml.indexOf('<body>')+6, responseHtml.indexOf('</body>'));
				
				oDiv.style.left = nodeInput.offsetLeft + 'px';
				oDiv.style.top = (nodeInput.offsetTop + nodeInput.clientHeight) + 'px';
				oDiv.style.width = nodeInput.clientWidth + 'px';
				oDiv.style.display = 'block';
				oDiv.innerHTML = responseHtml;
			}
		}
	} else {
		oDiv.innerHTML = '';
		oDiv.style.display = 'none';
	}
}

function selectNode(nodeID){
	document.getElementById('node_search_id').value = nodeID;
	alert('WIP: ' + nodeID);
}