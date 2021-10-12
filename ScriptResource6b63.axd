﻿(function(a){Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.LayoutBuilderEngine=function(b){this._selectedTable=null;
this._selectedCell=null;
this._selectedRow=null;
this._selectedRowCells=[];
this._selectedRowIndex=null;
this._tableState=[];
this._tableStateRowsCount=0;
this._tableStateColsCount=0;
this._tableStateId="LayoutBuilder_tableState_dump";
this._tableStateTableStyle="radtblder_stateMatrixTable";
this._tableStateCellStyle="radtblder_stateMatrixCell";
this._selectedCellClassName="";
this._states=[];
this._currentStateIndex=-1;
this.set_selectedTable(b);
if(this._selectedTable){this.set_selectedCell();
}if(!b){b=document.createElement("table");
}Telerik.Web.UI.LayoutBuilderEngine.initializeBase(this,[b]);
};
Telerik.Web.UI.LayoutBuilderEngine.prototype={get_selectedTable:function(){return this._selectedTable;
},set_selectedTable:function(b){this._selectedTable=null;
if(b&&b.tagName=="TABLE"){this._selectedTable=b;
this._setTableState();
}},get_selectedCell:function(){return this._selectedCell;
},set_selectedCell:function(d,c){if(!this._selectedTable||this._selectedTable.tagName!="TABLE"){return;
}if(!d){d=this._selectedTable.rows[0].cells[0];
}if(d.tagName=="TD"||d.tagName=="TH"){if(this._selectedCell!=d){this._selectedCellClassName=d.className;
}this._selectedCell=d;
}else{this._selectedCell=null;
}if(this._selectedCell){this.set_selectedRow();
}if(this._selectedCell&&(false!=c)&&this._currentStateIndex==-1){if(this._states.length==1&&this._states[0]["commandName"]=="selection"){this._states=[];
}var b={commandName:"selection",selectedColIndex:this._selectedCell.cellIndex,selectedRowIndex:this._selectedRowIndex,nextSelectedColIndex:this._selectedCell.cellIndex,nextSelectedRowIndex:this._selectedRowIndex};
this._storeState(b);
}},set_selectedRow:function(){if(this._selectedCell){this._selectedRow=this._selectedCell.parentNode;
if(this._selectedRow){this._selectedRowCells=this._selectedRow.cells;
this._selectedRowIndex=this._selectedRow.rowIndex;
}else{this._selectedRowCells=null;
this._selectedRowIndex=null;
}}},_raiseException:function(b){},_initializesTableStateCounts:function(){var k=this._selectedTable.rows;
var h=k.length;
var d=0;
for(var e=0;
e<h;
e++){var g=0;
var b=k[e].cells;
var c=b.length;
for(var f=0;
f<c;
f++){g+=this._getColSpan(b[f]);
}if(d<g){d=g;
}}this._tableStateRowsCount=h;
this._tableStateColsCount=d;
},dumpState:function(){var g=document.createElement("Table");
var e=$get(this._tableStateId);
if(e){e.parentNode.removeChild(e);
}g.id=this._tableStateId;
g.className=this._tableStateTableStyle;
var f=this._tableState.length;
for(var c=0;
c<f;
c++){var b=this._tableState[c].length;
var k=g.insertRow(c);
for(var d=0;
d<b;
d++){var h=k.insertCell(d);
h.className=this._tableStateCellStyle;
h.innerHTML=this._tableState[c][d];
}}this._selectedTable.parentNode.appendChild(g);
},_initializesTableState:function(e,b){for(var c=0;
c<e;
c++){this._tableState[c]=[];
for(var d=0;
d<b;
d++){this._tableState[c][d]="";
}}},_processTD:function(k,g,b){var h=this._getRowSpan(k);
var c=this._getColSpan(k);
for(var d=0;
d<h;
d++){for(var f=0;
f<c;
f++){var e=g+d;
if(this._tableState[e]==a){this._tableState[e]=[];
}this._tableState[e][b+f]=k.parentNode.rowIndex+","+k.cellIndex;
}}},_setTableState:function(){this._tableState=[];
this._initializesTableStateCounts();
this._initializesTableState(this._tableStateRowsCount,this._tableStateColsCount);
var g=this._selectedTable.rows;
var h=g.length;
for(var f=0;
f<h;
f++){var e=0;
var c=g[f].cells;
var d=c.length;
for(var b=0;
b<d;
b++){while(this._tableState[f][e]){e++;
}this._processTD(c[b],f,e);
}}},_getStateValueIndexes:function(f,c){var g={};
var e=this._tableState.length-1;
if(f>e){f=e;
}var d=this._tableState[f][c];
if(d){var b=d.split(",");
if(b.length==2){g.rowIndex=parseInt(b[0],10);
g.colIndex=parseInt(b[1],10);
}}return g;
},_getSelectedTableCellByStateIndexes:function(g,c){try{var b=this._getStateValueIndexes(g,c);
var f=this._selectedTable.rows[b.rowIndex];
return(f!=a)?f.cells[b.colIndex]:null;
}catch(d){return null;
}},_getLeftTopStateIndexes:function(f,d){var g={};
var h=f+","+d;
for(var e=0;
e<this._tableStateRowsCount;
e++){var b=false;
for(var c=0;
c<this._tableStateColsCount;
c++){if(this._tableState[e][c]==h){g.rowIndex=e;
g.colIndex=c;
b=true;
break;
}}if(b){break;
}}return g;
},_getRightTopStateIndexes:function(f,d){var g={};
var h=f+","+d;
for(var e=0;
e<this._tableStateRowsCount;
e++){var b=false;
for(var c=this._tableStateColsCount-1;
c>-1;
c--){if(this._tableState[e][c]==h){g.rowIndex=e;
g.colIndex=c;
b=true;
break;
}}if(b){break;
}}return g;
},_getLeftBottomStateIndexes:function(f,d){var g={};
var h=f+","+d;
for(var e=(this._tableStateRowsCount-1);
e>-1;
e--){var b=false;
for(var c=0;
c<this._tableStateColsCount;
c++){if(this._tableState[e][c]==h){g.rowIndex=e;
g.colIndex=c;
b=true;
break;
}}if(b){break;
}}return g;
},_insertRow:function(c){var b=null;
if(this._selectedCell.tagName=="TH"){if(this._selectedRow){b=this._selectedRow.parentNode.insertRow(c);
}}else{b=this._selectedTable.insertRow(c);
}return b;
},_insertCell:function(g,c,d,i){if(!c){c=0;
}var b=null;
if(g&&g.tagName=="TR"){var f=g.parentNode;
if(f.tagName=="THEAD"){var e=g.document?g.document:g.ownerDocument;
b=e.createElement("th");
if(d){b.innerHTML=d;
}if(g.cells.length==c){g.appendChild(b);
}else{var h=g.cells[c];
if(h){g.insertBefore(b,h);
}}}else{b=g.insertCell(c);
if(d){b.innerHTML=d;
}}$telerik.mergeElementAttributes(i,b);
this._cleanNewCellAttributes(b);
}return b;
},_cleanNewCellAttributes:function(b){if(!b){return;
}b.removeAttribute("rowSpan");
b.removeAttribute("colSpan");
b.removeAttribute("name");
b.removeAttribute("ID");
},_getRowSpan:function(b){if(b){var c=parseInt(b.getAttribute("rowSpan"),10);
if(isNaN(c)){c=1;
}return c;
}return 0;
},_getColSpan:function(c){if(c){var b=parseInt(c.getAttribute("colSpan"),10);
if(isNaN(b)){b=1;
}return b;
}return 0;
},_setRowSpan:function(b,c){if(!b){return;
}c=parseInt(c,10);
if(isNaN(c)||c<2){b.removeAttribute("rowSpan");
}else{b.setAttribute("rowSpan",c);
}},_setColSpan:function(c,b){if(!c){return;
}b=parseInt(b,10);
if(isNaN(b)||b<2){c.removeAttribute("colSpan");
}else{c.setAttribute("colSpan",b);
}},_alterRowSpan:function(d,b){var e=this._getRowSpan(d)+b;
var c=true;
if(e>0){this._setRowSpan(d,e);
}else{c=false;
}return c;
},canUndo:function(){return(0<this._currentStateIndex);
},canRedo:function(){return(this._currentStateIndex<this._states.length-1);
},undo:function(){var e=this._currentStateIndex-1;
var c=this._states[this._currentStateIndex];
if(e<this._states.length){var d=this._states[e];
if(d){this._replaceSelectedTable(d);
this._currentStateIndex--;
var b={commandName:"undo "+c.commandName,selectedColIndex:c.selectedColIndex,selectedRowIndex:c.selectedRowIndex};
this._raiseEvent("onCommand",b);
}}},redo:function(){var e=this._currentStateIndex+1;
var c=this._states[this._currentStateIndex];
if(e<this._states.length){var d=this._states[e];
if(d){this._replaceSelectedTable(d);
this._currentStateIndex++;
var b={commandName:"redo "+c.commandName,selectedColIndex:c.selectedColIndex,selectedRowIndex:c.selectedRowIndex};
this._raiseEvent("onCommand",b);
}}},_replaceSelectedTable:function(c){var b=this._selectedTable.parentNode;
var e=c.table.cloneNode(true);
b.insertBefore(e,this._selectedTable);
b.removeChild(this._selectedTable);
this.set_selectedTable(e);
var d=e.rows[c.nextSelectedRowIndex].cells[c.nextSelectedColIndex];
this._selectedCellClassName=c.selectedCellClassName;
this.set_selectedCell(d,false);
},_storeState:function(b){if(!this._selectedTable){return false;
}this._currentStateIndex++;
if(this._states.length!=0){this._states=this._states.slice(0,this._currentStateIndex);
}var c={table:this._selectedTable.cloneNode(true),selectedRowIndex:b.selectedRowIndex,selectedColIndex:b.selectedColIndex,nextSelectedRowIndex:b.nextSelectedRowIndex,nextSelectedColIndex:b.nextSelectedColIndex,selectedCellClassName:this._selectedCellClassName,commandName:b.commandName};
this._states.push(c);
},_removeEptyTrElements:function(){if(!this._selectedTable){return false;
}var n=this._selectedTable.rows;
var o=n.length;
var p=[];
var e=0,f,m;
for(f=0;
f<o;
f++){m=n[f];
var d=m.cells.length;
if(d==0){p[e++]=m;
if(f!=0){var h=n[f-1];
var k=h.cells;
var l=k.length;
for(var g=0;
g<l;
g++){var b=k[g];
var c=this._getRowSpan(b);
if(c>1){this._setRowSpan(b,c-1);
}}}}}for(f=0;
f<e;
f++){m=p[0];
m.parentNode.removeChild(m);
}},executeCommand:function(d,c){if(!this._selectedTable||!this._selectedCell||!d){return false;
}var e=true;
var b={commandName:d,selectedColIndex:this._selectedCell.cellIndex,selectedRowIndex:this._selectedRowIndex,nextSelectedColIndex:this._selectedCell.cellIndex,nextSelectedRowIndex:this._selectedRowIndex};
switch(d){case"deleteColumn":case"deleteRow":case"deleteCell":case"insertRowAbove":case"insertRowBelow":case"insertColumnToTheLeft":case"insertColumnToTheRight":case"mergeLeft":case"mergeTop":case"mergeRight":case"mergeDown":case"setAsContentCell":case"splitCellHorizontally":case"splitCellVertically":e=this[d](c);
break;
default:this._raiseException(d+" is not implemented!");
return false;
}if(e){this._setTableState();
this._raiseEvent("onCommand",b);
this.set_selectedRow();
if(d!="deleteColumn"&&d!="deleteRow"&&d!="deleteCell"){b.nextSelectedColIndex=this._selectedCell.cellIndex;
b.nextSelectedColIndex=this._selectedRowIndex;
}this._storeState(b);
this._removeEptyTrElements();
}return e;
},_alterNonCurrentRowCellsRowspan:function(f,b){var c=";";
for(var h=0;
h<this._tableStateColsCount;
h++){var d=this._getStateValueIndexes(f,h);
var g=d.rowIndex;
var e=d.colIndex;
if(d.rowIndex!=f){var i=g+","+e+";";
if(c.indexOf(";"+i)==-1){c+=i;
this._alterRowSpan(this._selectedTable.rows[g].cells[e],b);
}}}},_getNewCellIndex:function(j,c,e){var g=j+1;
var m=j+","+c;
var f=(e)?e:0;
for(var k=0;
k<this._tableStateColsCount;
k++){if(this._tableState[g][k]==m){if(k!=0){var h=k-1;
for(var d=h;
d>0;
d--){var b=this._getStateValueIndexes(g,h);
var l=b.rowIndex;
if(l==g){var n=b.colIndex;
f=parseInt(n,10);
break;
}}}break;
}}return f;
},deleteRow:function(c){if(!this._selectedTable){return false;
}var d=this._getLeftTopStateIndexes(this._selectedRowIndex,this._selectedCell.cellIndex);
var p=d.rowIndex;
var s=p-1;
var f=this._selectedRowIndex+1;
var e=this._selectedTable.rows[f];
if(typeof(p)!="undefined"&&typeof(d.colIndex)!="undefined"){var n=";";
var l=0;
for(var o=0;
o<this._tableStateColsCount;
o++){var q=this._tableState[p][o]+";";
if(n.indexOf(";"+q)==-1){n+=q;
var g=this._getSelectedTableCellByStateIndexes(p,o);
var h=this._getRowSpan(g);
if(h!=1){if(s>=0&&this._tableState[p][o]==this._tableState[s][o]){var r=this._getSelectedTableCellByStateIndexes(s,o);
this._alterRowSpan(r,-1);
}else{for(var j=o;
j>-1;
j--){var b=this._getStateValueIndexes(f,j);
if(f==b.rowIndex){l=parseInt(b.colIndex,10)+1;
break;
}}var k=this._insertCell(e,l,g.innerHTML,g);
this._setColSpan(k,this._getColSpan(g));
this._setRowSpan(k,h-1);
l++;
}}}}var m=this._selectedRow.parentNode;
if(m){m.removeChild(this._selectedRow);
}return true;
}},insertRowBelow:function(b){if(!this._selectedTable){return false;
}var c=this._getLeftBottomStateIndexes(this._selectedRowIndex,this._selectedCell.cellIndex);
if(typeof(c.rowIndex)!="undefined"&&typeof(c.colIndex)!="undefined"){var k=c.rowIndex;
var i=k+1;
var h=this._insertRow(i);
$telerik.mergeElementAttributes(this._selectedRow,h);
var j=";";
for(var f=0;
f<this._tableStateColsCount;
f++){var l=this._tableState[k][f];
if(j.indexOf(";"+l+";")==-1){j+=l+";";
var d=this._getSelectedTableCellByStateIndexes(k,f);
if(this._getRowSpan(d)>1&&i!=this._tableStateRowsCount&&this._tableState[k][f]==this._tableState[i][f]){this._alterRowSpan(d,1);
}else{var g=this._insertCell(h,h.cells.length,"&nbsp;",d);
var e=this._getColSpan(d);
if(e>1){this._setColSpan(g,e);
}}}}}return true;
},insertRowAbove:function(b){if(!this._selectedTable){return false;
}var j=this._insertRow(this._selectedRowIndex);
$telerik.mergeElementAttributes(this._selectedRow,j);
var h=0;
var f=this._selectedRowCells.length;
this._alterNonCurrentRowCellsRowspan(this._selectedRowIndex,1);
for(var e=0;
e<f;
e++){var c=this._selectedRowCells[e];
var d=this._getColSpan(this._selectedRowCells[e]);
var g=this._insertCell(j,h++,"&nbsp;",c);
if(d>1){this._setColSpan(g,d);
}}return true;
},insertColumnToTheLeft:function(b){if(!this._selectedTable){return false;
}var d=this._getLeftTopStateIndexes(this._selectedRowIndex,this._selectedCell.cellIndex);
var g,j;
if(typeof(d.colIndex)!="undefined"){var o=parseInt(d.colIndex,10);
if(isNaN(o)){o=0;
}for(var l=0;
l<this._tableStateRowsCount;
l++){var n=this._selectedTable.rows[l];
var c=this._getStateValueIndexes(l,o);
var q=c.rowIndex;
var p=c.colIndex;
if(q==l){var f=false;
if(o==0){f=true;
}else{g=this._selectedTable.rows[q].cells[p];
var h=this._getColSpan(g);
if(this._tableState[l][o]==this._tableState[l][o-1]&&h>1&&l!=this._selectedRowIndex){g.setAttribute("colSpan",h+1);
var m=this._getRowSpan(g);
if(m>1){for(j=1;
j<m;
j++){l++;
}}}else{f=true;
}}if(f){this._insertCell(n,p,"&nbsp;",n.cells[p]);
}}else{var k=0;
for(j=o-1;
j>-1;
j--){var e=this._getStateValueIndexes(l,j);
if(e.rowIndex==l){k=e.colIndex+1;
break;
}}g=this._getSelectedTableCellByStateIndexes(l,o);
this._insertCell(n,k,"&nbsp;",g);
}}}return true;
},insertColumnToTheRight:function(b){if(!this._selectedTable){return false;
}var d=this._getRightTopStateIndexes(this._selectedRowIndex,this._selectedCell.cellIndex);
var g,j;
if(typeof(d.colIndex)!="undefined"){var o=parseInt(d.colIndex,10);
if(isNaN(o)){o=0;
}for(var l=0;
l<this._tableStateRowsCount;
l++){var n=this._selectedTable.rows[l];
var c=this._getStateValueIndexes(l,o);
var q=c.rowIndex;
var p=parseInt(c.colIndex,10);
if(isNaN(p)){p=0;
}if(q==l){var f=false;
if(o==this._tableStateColsCount-1){f=true;
}else{g=this._selectedTable.rows[q].cells[p];
var h=this._getColSpan(g);
if(this._tableState[l][o]==this._tableState[l][o+1]&&h>1&&l!=this._selectedRowIndex){g.setAttribute("colSpan",h+1);
var m=this._getRowSpan(g);
if(m>1){for(j=1;
j<m;
j++){l++;
}}}else{f=true;
}}if(f){this._insertCell(n,p+1,"&nbsp;",n.cells[p]);
}}else{var k=this._selectedTable.rows[l].cells.length;
for(j=o+1;
j<this._tableStateColsCount;
j++){var e=this._getStateValueIndexes(l,j);
if(e.rowIndex==l){k=parseInt(e.colIndex,10);
if(isNaN(k)){k=0;
}break;
}}g=this._getSelectedTableCellByStateIndexes(l,o);
this._insertCell(n,k,"&nbsp;",g);
}}}return true;
},deleteColumn:function(b){if(!this._selectedTable){return false;
}var d=this._getLeftTopStateIndexes(this._selectedRowIndex,this._selectedCell.cellIndex);
var l=d.colIndex;
if(typeof(l)!="undefined"){for(var h=0;
h<this._tableStateRowsCount;
h++){var k=this._selectedTable.rows[h];
var c=this._getStateValueIndexes(h,l);
var m=parseInt(c.colIndex,10);
var e=k.cells[m];
var j=this._getRowSpan(e);
var f=this._getColSpan(e);
if(f>1){this._setColSpan(e,f-1);
}else{k.removeChild(e);
}if(j>1){for(var g=1;
g<j;
g++){h++;
}}}return true;
}return false;
},canMergeLeft:function(d){if(!d){d=this._selectedCell;
}if(!d||!d.parentNode){return false;
}var c=true;
var h=d.cellIndex;
var e=d.parentNode;
var f=e.rowIndex;
if(h==0||h==-1){c=false;
}else{var b=this._getLeftTopStateIndexes(f,h);
if(typeof(b.rowIndex)=="undefined"||typeof(b.colIndex)=="undefined"){return false;
}var g=this._getSelectedTableCellByStateIndexes(b.rowIndex,b.colIndex-1);
if(g){if(g.parentNode.rowIndex!=f||this._getRowSpan(d)!=this._getRowSpan(g)){c=false;
}}}return c;
},mergeLeft:function(b){var d=(b&&b.cell)?b.cell:this._selectedCell;
if(!d||!d.parentNode){return false;
}var c=true;
var e=d.parentNode;
if(this.canMergeLeft(d)){var f=e.cells[d.cellIndex-1];
this._setColSpan(d,this._getColSpan(d)+this._getColSpan(f));
var g=f.innerHTML;
if(g!=" "&&g!="&nbsp;"){d.innerHTML=g+"<br />"+d.innerHTML;
}e.removeChild(f);
}else{this._raiseException("The cell can not be merged left!");
c=false;
}return c;
},canMergeTop:function(d){if(!d){d=this._selectedCell;
}if(!d||!d.parentNode){return false;
}var c=true;
var e=d.parentNode.rowIndex;
if(e==0){c=false;
}else{var b=this._getLeftTopStateIndexes(e,d.cellIndex);
if(typeof(b.rowIndex)=="undefined"||typeof(b.colIndex)=="undefined"){return false;
}var f=this._getSelectedTableCellByStateIndexes(b.rowIndex-1,b.colIndex);
c=this.canMergeDown(f);
}return c;
},mergeTop:function(b){var e=(b&&b.cell)?b.cell:this._selectedCell;
if(!e||!e.parentNode){return false;
}var d=true;
if(this.canMergeTop(e)){var g=e.parentNode;
var c=this._getLeftTopStateIndexes(g.rowIndex,e.cellIndex);
var h=this._getSelectedTableCellByStateIndexes(c.rowIndex-1,c.colIndex);
var f=e.innerHTML;
if(f!=" "&&f!="&nbsp;"){h.innerHTML+="<br />"+f;
}this.set_selectedCell(h,false);
this._alterRowSpan(h,this._getRowSpan(e));
g.removeChild(e);
}else{this._raiseException("The cell cannot be merged top!");
d=false;
}return d;
},canMergeRight:function(d){if(!d){d=this._selectedCell;
}if(!d||!d.parentNode){return false;
}var c=true;
var e=d.cellIndex;
var h=d.parentNode;
var i=h.rowIndex;
if(typeof(i)=="undefined"){return false;
}var f=h.cells.length;
if(e==f-1){c=false;
}else{var b=this._getRightTopStateIndexes(i,e);
if(typeof(b.rowIndex)=="undefined"||typeof(b.colIndex)=="undefined"){return false;
}var g=this._getSelectedTableCellByStateIndexes(b.rowIndex,b.colIndex+1);
if(g&&(g.parentNode.rowIndex!=i||this._getRowSpan(d)!=this._getRowSpan(g))){c=false;
}}return c;
},mergeRight:function(b){var d=(b&&b.cell)?b.cell:this._selectedCell;
if(!d||!d.parentNode){return false;
}var c=true;
if(this.canMergeRight(d)){var e=d.parentNode;
var f=e.cells[d.cellIndex+1];
var g=f.innerHTML;
if(g!=" "&&g!="&nbsp;"){d.innerHTML+="<br />"+g;
}this._setColSpan(d,this._getColSpan(d)+this._getColSpan(f));
e.removeChild(f);
}else{this._raiseException("The cell can not be merged right!");
c=false;
}return c;
},canMergeDown:function(e){if(!e){e=this._selectedCell;
}if(!e||!e.parentNode){return false;
}var d=true;
var i=this._getRowSpan(e);
var h=this._getColSpan(e);
var f=e.parentNode.rowIndex;
var g=f+i;
if(g==this._tableStateRowsCount){d=false;
}else{var c=this._getLeftTopStateIndexes(f,e.cellIndex);
if(typeof(c.colIndex)!="undefined"){var j=c.colIndex;
var b=this._getStateValueIndexes(g,j);
var n=b.rowIndex;
var m=parseInt(b.colIndex,10);
if(this._selectedTable.rows[n]==a){return false;
}var k=this._selectedTable.rows[n].cells[m];
if(k.parentNode.parentNode.tagName!=e.parentNode.parentNode.tagName){return false;
}var l=this._getColSpan(k);
if(h!=l){d=false;
}else{if(j!=0){if(this._tableState[g]==a||this._tableState[g][j-1]==this._tableState[g][j]){d=false;
}}}}}return d;
},mergeDown:function(b){var e=(b&&b.cell)?b.cell:this._selectedCell;
if(!e||!e.parentNode){return false;
}var d=true;
if(this.canMergeDown(e)){var c=this._getLeftBottomStateIndexes(e.parentNode.rowIndex,e.cellIndex);
var f=this._getSelectedTableCellByStateIndexes(c.rowIndex+1,c.colIndex);
var g=f.innerHTML;
if(g!=" "&&g!="&nbsp;"){e.innerHTML+="<br />"+g;
}this._alterRowSpan(e,this._getRowSpan(f));
f.parentNode.removeChild(f);
}else{this._raiseException("The cell can not be merged down!");
d=false;
}return d;
},canDeleteCell:function(b){if(!b){b=this._selectedCell;
}if(!b||!b.parentNode){return false;
}var d=0;
var e=this._getRowSpan(b);
var c=this._getColSpan(b);
if(e==this._tableStateRowsCount){d=1;
}else{if(c==this._tableStateColsCount){d=2;
}else{if(this.canMergeLeft(b)){d=3;
}else{if(this.canMergeRight(b)){d=4;
}else{if(this.canMergeDown(b)){d=5;
}else{if(this.canMergeTop(b)){d=6;
}}}}}}return d;
},deleteCell:function(b){var f=(b&&b.cell)?b.cell:this._selectedCell;
if(!f||!f.parentNode){return false;
}var d=true;
var j=f.parentNode;
var e=this.canDeleteCell(f);
var c;
switch(e){case 1:j.removeChild(f);
break;
case 2:j.parentNode.removeChild(j);
break;
case 3:var h=j.cells[f.cellIndex-1];
this.set_selectedCell(h,false);
d=this.mergeRight();
break;
case 4:var i=j.cells[f.cellIndex+1];
this.set_selectedCell(i,false);
d=this.mergeLeft();
break;
case 5:c=this._getLeftBottomStateIndexes(j.rowIndex,f.cellIndex);
var g=this._getSelectedTableCellByStateIndexes(c.rowIndex+1,c.colIndex);
this.set_selectedCell(g,false);
d=this.mergeTop();
break;
case 6:c=this._getLeftBottomStateIndexes(j.rowIndex,f.cellIndex);
var k=this._getSelectedTableCellByStateIndexes(c.rowIndex-1,c.colIndex);
this.set_selectedCell(k,false);
d=this.mergeDown();
break;
default:this._raiseException("The cell can not be deleted!");
d=false;
break;
}if(d&&j&&j.cells.length==0){j.parentNode.removeChild(j);
}return d;
},splitCellHorizontally:function(d){if(!this._selectedCell){return false;
}var g=this._selectedCell;
var f=true;
var k=this._getColSpan(g);
var i=g.cellIndex;
var q=this._selectedRow;
var r=this._selectedRowIndex;
var t=r+","+i;
var n=this._insertCell(q,i+1,"&nbsp;",g);
this._setRowSpan(n,this._getRowSpan(g));
if(k==1){var e=this._getLeftTopStateIndexes(r,i);
var j=e.colIndex;
var c=";";
for(var s=0;
s<this._tableStateRowsCount;
s++){var m=this._tableState[s][j];
if(s!=r&&m!=t&&c.indexOf(";"+m+";")){c+=m+";";
var b=this._getSelectedTableCellByStateIndexes(s,j);
this._setColSpan(b,this._getColSpan(b)+1);
}}}else{var p=(d)?parseInt(d.rightColSpan,10):null;
var h;
var o;
if(!p||isNaN(p)||p>=k){var l=Math.ceil(k/2);
if(k%2==0){h=l;
o=l;
}else{h=l;
o=l-1;
}}else{h=k-p;
o=p;
}this._setColSpan(g,h);
this._setColSpan(n,o);
}return f;
},splitCellVertically:function(e){var i=this._selectedCell;
if(!i){return false;
}if(!i.parentNode){return false;
}var h=true;
var s=this._getRowSpan(i);
var j=i.cellIndex;
var q=this._selectedRow;
var r=this._selectedRowIndex;
var c=";";
var b=null;
var w;
var f=[];
var m;
if(s==1){for(var u=0;
u<this._tableStateColsCount;
u++){b=this._getSelectedTableCellByStateIndexes(r,u);
w=this._tableState[r][u];
f=this._getStateValueIndexes(r,u);
if((b.cellIndex!=j||r!=f.rowIndex)&&c.indexOf(";"+w+";")==-1){c+=w+";";
this._alterRowSpan(b,1);
}}var p=this._insertRow(r+1);
$telerik.mergeElementAttributes(q,p);
m=this._insertCell(p,p.cells.length,"&nbsp;",i);
this._setColSpan(m,this._getColSpan(i));
}else{var t=Math.ceil(s/2),k,o;
var l=(e)?parseInt(e.downRowSpan,10):null;
if(!l||isNaN(l)||l>=s){if(s%2==0){k=t;
o=t;
}else{k=t;
o=t-1;
}}else{k=s-l;
o=l;
}this._setRowSpan(i,k);
var g=this._getLeftTopStateIndexes(r,j);
var d=r+k;
var n=0;
for(var v=g.colIndex;
v>-1;
v--){f=this._getStateValueIndexes(d,v);
if(f.rowIndex==d){n=f.colIndex+1;
break;
}}m=this._insertCell(this._selectedTable.rows[d],n,"&nbsp;",i);
this._setColSpan(m,this._getColSpan(i));
this._setRowSpan(m,o);
}return h;
},setAsContentCell:function(b){var c=this._selectedCell;
if(!c){return false;
}if(!c.parentNode){return false;
}c.style.width="100%";
c.style.height="100%";
return true;
},add_onCommand:function(b){this.get_events().addHandler("onCommand",b);
},_raiseEvent:function(c,b){var d=this.get_events().getHandler(c);
if(d){if(!b){b=Sys.EventArgs.Empty;
}d(this,b);
}}};
Telerik.Web.UI.LayoutBuilderEngine.registerClass("Telerik.Web.UI.LayoutBuilderEngine",Telerik.Web.UI.RadWebControl);
})();
