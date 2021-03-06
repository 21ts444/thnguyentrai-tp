Type.registerNamespace("Telerik.Web.UI");
Telerik.Web.UI.SpellCheckService=function(){Telerik.Web.UI.SpellCheckService.initializeBase(this);
this._url="Telerik.Web.UI.SpellCheckHandler.axd";
this._language="en-US";
this._configuration=null;
};
Telerik.Web.UI.SpellCheckService.prototype={spellCheck:function(a){this._sendRequest(this._getPostData("SpellCheck",a));
},addCustomWord:function(a){this._sendRequest(this._getPostData("AddCustom",a));
},_processResponse:function(b,a){var d=b.get_statusCode();
if(b.get_responseAvailable()&&200==d&&b.get_responseData().length>0){var c=b.get_object();
if(c.badWords!=null){c.badWords=eval(c.badWords);
}if(c.wordOffsets!=null){c.wordOffsets=eval(c.wordOffsets);
}this.raise_complete(b.get_object());
}else{if(b.get_timedOut()){alert("Spell Check Request time out");
}else{if(b.get_aborted()){alert("Spell Check Request aborted");
}else{if(404==d){window.alert("Web.config registration missing!\n The spellchecking functionality requires a HttpHandler registration in web.config. Please, use the control Smart Tag to add the handler automatically, or see the help for more information.\n\n"+this.get_url());
}else{if(d>0&&d!=200){window.alert("Spell Check Handler Server Error:"+d+"\n"+b.get_responseData());
}}}}}},_sendRequest:function(b,a){var c=new Sys.Net.WebRequest();
c.set_url(this.get_url());
c.set_httpVerb("POST");
c.set_body(b);
c.add_completed(Function.createDelegate(this,this._processResponse));
c.invoke();
},_getPostData:function(b,a){return"DictionaryLanguage="+this._encode(this._language)+"&Configuration="+this._encode(this._configuration)+"&CommandArgument="+this.encodePostbackContent(a).replace(/%/g,"~")+"&CommandName="+b;
},_encode:function(f){var d=true;
var c=window.escape;
try{var a=$telerik.isIE?document.charset:document.characterSet;
a=a+"";
if(a&&a.toLowerCase().indexOf("utf")==-1){d=false;
}}catch(b){}return(encodeURIComponent&&d)?encodeURIComponent(f):c(f);
},initialize:function(){Telerik.Web.UI.SpellCheckService.callBaseMethod(this,"initialize");
},dispose:function(){Telerik.Web.UI.SpellCheckService.callBaseMethod(this,"dispose");
},get_url:function(){return this._url;
},set_url:function(a){this._url=a;
},get_language:function(){return this._language;
},set_language:function(a){this._language=a;
},get_configuration:function(){return this._configuration;
},set_configuration:function(a){this._configuration=a;
},add_complete:function(a){this.get_events().addHandler("complete",a);
},remove_complete:function(a){this.get_events().removeHandler("complete",a);
},raise_complete:function(a){var b=this.get_events().getHandler("complete");
if(b){if(!a){a=Sys.EventArgs.Empty;
}b(this,a);
}},_encodeHtmlContent:function(b,e){var a=new Array("%","<",">","!",'"',"#","$","&","'","(",")",",",":",";","=","?","[","]","\\","^","`","{","|","}","~","+");
var d=b;
var c;
if(e){for(c=0;
c<a.length;
c++){d=d.replace(new RegExp("\\x"+a[c].charCodeAt(0).toString(16),"ig"),"%"+a[c].charCodeAt(0).toString(16));
}}else{for(c=a.length-1;
c>=0;
c--){d=d.replace(new RegExp("%"+a[c].charCodeAt(0).toString(16),"ig"),a[c]);
}}return d;
},encodePostbackContent:function(a){return this._encodeHtmlContent(a,true);
},decodePostbackContent:function(a){return this._encodeHtmlContent(a,false);
}};
Telerik.Web.UI.SpellCheckService.registerClass("Telerik.Web.UI.SpellCheckService",Sys.Component);
