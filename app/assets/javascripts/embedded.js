function Clicksign(o){"use strict";var r,u,t=window.location.protocol+"//"+window.location.host,e={},n=function(t){(e[t]||[]).forEach(function(t){t()})},c=function(t){n(t.data)};return{endpoint:"https://app.clicksign.com",origin:t,mount:function(t){var n="/sign/"+o,e="?embedded=true&origin="+this.origin,i=this.endpoint+n+e;return u=document.getElementById(t),(r=document.createElement("iframe")).setAttribute("src",i),r.setAttribute("style","width: 100%; height: 100%;"),window.addEventListener("message",c),u.appendChild(r)},unmount:function(){return r&&(u.removeChild(r),r=u=null,window.removeEventListener("message",n)),!0},on:function(t,n){return e[t]||(e[t]=[]),e[t].push(n)},trigger:n}}
