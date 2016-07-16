<!DOCTYPE html>
<html lang="en" >

<head>

	
	<script>
window.ts_endpoint_url = "https:\/\/slack.com\/beacon\/timing";

(function(e) {
	var n=Date.now?Date.now():+new Date,r=e.performance||{},t=[],a={},i=function(e,n){for(var r=0,a=t.length,i=[];a>r;r++)t[r][e]==n&&i.push(t[r]);return i},o=function(e,n){for(var r,a=t.length;a--;)r=t[a],r.entryType!=e||void 0!==n&&r.name!=n||t.splice(a,1)};r.now||(r.now=r.webkitNow||r.mozNow||r.msNow||function(){return(Date.now?Date.now():+new Date)-n}),r.mark||(r.mark=r.webkitMark||function(e){var n={name:e,entryType:"mark",startTime:r.now(),duration:0};t.push(n),a[e]=n}),r.measure||(r.measure=r.webkitMeasure||function(e,n,r){n=a[n].startTime,r=a[r].startTime,t.push({name:e,entryType:"measure",startTime:n,duration:r-n})}),r.getEntriesByType||(r.getEntriesByType=r.webkitGetEntriesByType||function(e){return i("entryType",e)}),r.getEntriesByName||(r.getEntriesByName=r.webkitGetEntriesByName||function(e){return i("name",e)}),r.clearMarks||(r.clearMarks=r.webkitClearMarks||function(e){o("mark",e)}),r.clearMeasures||(r.clearMeasures=r.webkitClearMeasures||function(e){o("measure",e)}),e.performance=r,"function"==typeof define&&(define.amd||define.ajs)&&define("performance",[],function(){return r}) // eslint-disable-line
})(window);

</script>
<script>;(function() {

'use strict';


window.TSMark = function(mark_label) {
	if (!window.performance || !window.performance.mark) return;
	performance.mark(mark_label);
};
window.TSMark('start_load');


window.TSMeasureAndBeacon = function(measure_label, start_mark_label) {
	if (start_mark_label === 'start_nav' && window.performance && window.performance.timing) {
		window.TSBeacon(measure_label, (new Date()).getTime() - performance.timing.navigationStart);
		return;
	}
	if (!window.performance || !window.performance.mark || !window.performance.measure) return;
	performance.mark(start_mark_label + '_end');
	try {
		performance.measure(measure_label, start_mark_label, start_mark_label + '_end');
		window.TSBeacon(measure_label, performance.getEntriesByName(measure_label)[0].duration);
	} catch(e) { return; }
};


window.TSBeacon = function(label, value) {
	var endpoint_url = window.ts_endpoint_url || 'https://slack.com/beacon/timing';
	(new Image()).src = endpoint_url + '?data=' + encodeURIComponent(label + ':' + value);
};

})();
</script>
 

<script>
window.TSMark('step_load');
</script>	<noscript><meta http-equiv="refresh" content="0; URL=/files/thatmose/F1SA0S41J/seeds.rb?nojsmode=1" /></noscript>
<script>(function() {
        'use strict';

	var start_time = Date.now();
	var logs = [];
	var connecting = true;
	var ever_connected = false;
	var log_namespace;

	var logWorker = function(ob) {
		var log_str = ob.secs+' start_label:'+ob.start_label+' measure_label:'+ob.measure_label+' description:'+ob.description;

		if (TS.metrics.getLatestMark(ob.start_label)) {
			TS.metrics.measure(ob.measure_label, ob.start_label);
			TS.log(88, log_str);

			if (ob.do_reset) {
				window.TSMark(ob.start_label);
			}
		} else {
			TS.maybeWarn(88, 'not timing: '+log_str);
		}
	}

	var log = function(k, description) {
		var secs = (Date.now()-start_time)/1000;

		logs.push({
			k: k,
			d: description,
			t: secs,
			c: !!connecting
		})

		if (!window.boot_data) return;
		if (!window.TS) return;
		if (!TS.metrics) return;
		if (!connecting) return;

		
		log_namespace = log_namespace || (function() {
			if (boot_data.app == 'client') return 'client';
			if (boot_data.app == 'space') return 'post';
			if (boot_data.app == 'api') return 'apisite';
			if (boot_data.app == 'mobile') return 'mobileweb';
			if (boot_data.app == 'web' || boot_data.app == 'oauth') return 'web';
			return 'unknown';
		})();

		var modifier = (TS.boot_data.feature_no_rollups) ? '_no_rollups' : '';

		logWorker({
			k: k,
			secs: secs,
			description: description,
			start_label: ever_connected ? 'start_reconnect' : 'start_load',
			measure_label: 'v2_'+log_namespace+modifier+(ever_connected ? '_reconnect__' : '_load__')+k,
			do_reset: false,
		});
	}

	var setConnecting = function(val) {
		val = !!val;
		if (val == connecting) return;

		if (val) {
			log('start');
			if (ever_connected) {
				
				window.TSMark('start_reconnect');
				window.TSMark('step_reconnect');
				window.TSMark('step_load');
			}

			connecting = val;
			log('start');
		} else {
			log('over');
			ever_connected = true;
			connecting = val;
		}
	}

	window.TSConnLogger = {
		log: log,
		logs: logs,
		start_time: start_time,
		setConnecting: setConnecting
	}
})();</script>

<script type="text/javascript">
if(self!==top)window.document.write("\u003Cstyle>body * {display:none !important;}\u003C\/style>\u003Ca href=\"#\" onclick="+
"\"top.location.href=window.location.href\" style=\"display:block !important;padding:10px\">Go to Slack.com\u003C\/a>");
</script>

<script>(function() {
        'use strict';

        window.callSlackAPIUnauthed = function(method, args, callback) {
                var timestamp = Date.now() / 1000;  
                var version = (window.TS && TS.boot_data) ? TS.boot_data.version_uid.substring(0, 8) : 'noversion';
                var url = '/api/' + method + '?_x_id=' + version + '-' + timestamp;
                var req = new XMLHttpRequest();

                req.onreadystatechange = function() {
                        if (req.readyState == 4) {
                                req.onreadystatechange = null;
                                var obj;

                                if (req.status == 200 || req.status == 429) {
                                        try {
                                                obj = JSON.parse(req.responseText);
                                        } catch (err) {
                                                console.warn('unable to do anything with api rsp');
                                        }
                                }

                                obj = obj || {
                                        ok: false
                                }

                                callback(obj.ok, obj, args);
                        }
                }

                var async = true;
                req.open('POST', url, async);

                var form_data = new FormData();
                var has_data = false;
                Object.keys(args).map(function(k) {
                        if (k[0] === '_') return;
                        form_data.append(k, args[k]);
                        has_data = true;
                });

                if (has_data) {
                        req.send(form_data);
                } else {
                        req.send();
                }
        }
})();</script>

						
	
		<script>
			if (window.location.host == 'slack.com' && window.location.search.indexOf('story') < 0) {
				document.cookie = '__cvo_skip_doc=' + escape(document.URL) + '|' + escape(document.referrer) + ';path=/';
			}
		</script>
	

	
		<script type="text/javascript">
		
		try {
			if(window.location.hash && !window.location.hash.match(/^(#?[a-zA-Z0-9_]*)$/)) {
				window.location.hash = '';
			}
		} catch(e) {}
		
	</script>

	<script type="text/javascript">
				(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		ga('create', "UA-106458-17", 'slack.com');

				
		ga('send', 'pageview');
	
		(function(e,c,b,f,d,g,a){e.SlackBeaconObject=d;
		e[d]=e[d]||function(){(e[d].q=e[d].q||[]).push([1*new Date(),arguments])};
		e[d].l=1*new Date();g=c.createElement(b);a=c.getElementsByTagName(b)[0];
		g.async=1;g.src=f;a.parentNode.insertBefore(g,a)
		})(window,document,"script","https://h2.slack-edge.com/dcf8/js/libs/beacon.js","sb");
		sb('set', 'token', '3307f436963e02d4f9eb85ce5159744c');

					sb('set', 'user_id', "U1DMMG9NC");
							sb('set', 'user_' + "batch", "immediate-launch");
							sb('set', 'user_' + "created", "2016-06-02");
						sb('set', 'name_tag', "lighthouse" + '/' + "ikalu");
				sb('track', 'pageview');

		function track(a){ga('send','event','web',a);sb('track',a);}

	</script>


		<script type='text/javascript'>
		
		(function(f,b){if(!b.__SV){var a,e,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user".split(" ");
		for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=f.createElement("script");a.type="text/javascript";a.async=!0;a.src="//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";e=f.getElementsByTagName("script")[0];e.parentNode.insertBefore(a,e)}})(document,window.mixpanel||[]);
		

		mixpanel.init("12d52d8633a5b432975592d13ebd3f34");

		
			function mixpanel_track(){if(window.mixpanel)mixpanel.track.apply(mixpanel, arguments);}
			function mixpanel_track_forms(){if(window.mixpanel)mixpanel.track_forms.apply(mixpanel, arguments);}
			function mixpanel_track_links(){if(window.mixpanel)mixpanel.track_links.apply(mixpanel, arguments);}
		
	</script>
	
	<meta name="referrer" content="no-referrer">
		<meta name="superfish" content="nofish">

	<script type="text/javascript">



var TS_last_log_date = null;
var TSMakeLogDate = function() {
	var date = new Date();

	var y = date.getFullYear();
	var mo = date.getMonth()+1;
	var d = date.getDate();

	var time = {
	  h: date.getHours(),
	  mi: date.getMinutes(),
	  s: date.getSeconds(),
	  ms: date.getMilliseconds()
	};

	Object.keys(time).map(function(moment, index) {
		if (moment == 'ms') {
			if (time[moment] < 10) {
				time[moment] = time[moment]+'00';
			} else if (time[moment] < 100) {
				time[moment] = time[moment]+'0';
			}
		} else if (time[moment] < 10) {
			time[moment] = '0' + time[moment];
		}
	});

	var str = y + '/' + mo + '/' + d + ' ' + time.h + ':' + time.mi + ':' + time.s + '.' + time.ms;
	if (TS_last_log_date) {
		var diff = date-TS_last_log_date;
		//str+= ' ('+diff+'ms)';
	}
	TS_last_log_date = date;
	return str+' ';
}

var parseDeepLinkRequest = function(code) {
	var m = code.match(/"id":"([CDG][A-Z0-9]{8})"/);
	var id = m ? m[1] : null;

	m = code.match(/"team":"(T[A-Z0-9]{8})"/);
	var team = m ? m[1] : null;

	m = code.match(/"message":"([0-9]+\.[0-9]+)"/);
	var message = m ? m[1] : null;

	return { id: id, team: team, message: message };
}

if ('rendererEvalAsync' in window) {
	var origRendererEvalAsync = window.rendererEvalAsync;
	window.rendererEvalAsync = function(blob) {
		try {
			var data = JSON.parse(decodeURIComponent(atob(blob)));
			if (data.code.match(/handleDeepLink/)) {
				var request = parseDeepLinkRequest(data.code);
				if (!request.id || !request.team || !request.message) return;

				request.cmd = 'channel';
				TSSSB.handleDeepLinkWithArgs(JSON.stringify(request));
				return;
			} else {
				origRendererEvalAsync(blob);
			}
		} catch (e) {
		}
	}
}
</script>



<script type="text/javascript">

	var TSSSB = {
		call: function() {
			return false;
		}
	};

</script>
<script>TSSSB.env = (function() {
	'use strict';

	var v = {
		win_ssb_version: null,
		win_ssb_version_minor: null,
		mac_ssb_version: null,
		mac_ssb_version_minor: null,
		mac_ssb_build: null,
		lin_ssb_version: null,
		lin_ssb_version_minor: null,
		desktop_app_version: null
	};
	
	var is_win = (navigator.appVersion.indexOf("Windows") !== -1);
	var is_lin = (navigator.appVersion.indexOf("Linux") !== -1);
	var is_mac = !!(navigator.userAgent.match(/(OS X)/g));

	if (navigator.userAgent.match(/(Slack_SSB)/g) || navigator.userAgent.match(/(Slack_WINSSB)/g)) {
		
		var parts = navigator.userAgent.split('/');
		var version_str = parts[parts.length-1];
		var version_float = parseFloat(version_str);
		var version_parts = version_str.split('.');
		var version_minor = (version_parts.length == 3) ? parseInt(version_parts[2]) : 0;

		if (navigator.userAgent.match(/(AtomShell)/g)) {
			
			if (is_lin) {
				v.lin_ssb_version = version_float;
				v.lin_ssb_version_minor = version_minor;
			} else if (is_win) {
				v.win_ssb_version = version_float;
				v.win_ssb_version_minor = version_minor;
			} else if (is_mac) {
				v.mac_ssb_version = version_float;
				v.mac_ssb_version_minor = version_minor;
			}
			
			if (version_parts.length >= 3) {
				v.desktop_app_version = {
					major: parseInt(version_parts[0]),
					minor: parseInt(version_parts[1]),
					patch: parseInt(version_parts[2])
				}
			}
		} else {
			
			v.mac_ssb_version = version_float;
			v.mac_ssb_version_minor = version_minor;
			
			
			
			var app_ver = window.macgap && macgap.app && macgap.app.buildVersion && macgap.app.buildVersion();
			var matches = String(app_ver).match(/(?:\()(.*)(?:\))/);
			v.mac_ssb_build = (matches && matches.length == 2) ? parseInt(matches[1] || 0) : 0;
		}
	}

	return v;
})();
</script>


	<script type="text/javascript">
		
		var was_TS = window.TS;
		delete window.TS;
		TSSSB.call('didFinishLoading');
		if (was_TS) window.TS = was_TS;
	</script>
	    <title>seeds.rb | Lighthouse Labs Slack</title>
    <meta name="author" content="Slack">

	
		
	
	
					
	
				
	
	
	
	
			<!-- output_css "core" -->
    <link href="https://h2.slack-edge.com/e2c1/style/rollup-plastic.css" rel="stylesheet" type="text/css">

		<!-- output_css "before_file_pages" -->
    <link href="https://h2.slack-edge.com/4821/style/libs/codemirror.css" rel="stylesheet" type="text/css">
    <link href="https://h2.slack-edge.com/b2f1e/style/codemirror_overrides.css" rel="stylesheet" type="text/css">

	<!-- output_css "file_pages" -->
    <link href="https://h2.slack-edge.com/2ae7c/style/rollup-file_pages.css" rel="stylesheet" type="text/css">

	<!-- output_css "regular" -->
    <link href="https://h2.slack-edge.com/054b/style/print.css" rel="stylesheet" type="text/css">
    <link href="https://h2.slack-edge.com/1d9c/style/libs/lato-1-compressed.css" rel="stylesheet" type="text/css">

	

	
	
	
	

	
<link id="favicon" rel="shortcut icon" href="https://h2.slack-edge.com/66f9/img/icons/favicon-32.png" sizes="16x16 32x32 48x48" type="image/png" />

<link rel="icon" href="https://h2.slack-edge.com/0180/img/icons/app-256.png" sizes="256x256" type="image/png" />

<link rel="apple-touch-icon-precomposed" sizes="152x152" href="https://h2.slack-edge.com/66f9/img/icons/ios-152.png" />
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="https://h2.slack-edge.com/66f9/img/icons/ios-144.png" />
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="https://h2.slack-edge.com/66f9/img/icons/ios-120.png" />
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="https://h2.slack-edge.com/66f9/img/icons/ios-114.png" />
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="https://h2.slack-edge.com/0180/img/icons/ios-72.png" />
<link rel="apple-touch-icon-precomposed" href="https://h2.slack-edge.com/66f9/img/icons/ios-57.png" />

<meta name="msapplication-TileColor" content="#FFFFFF" />
<meta name="msapplication-TileImage" content="https://h2.slack-edge.com/66f9/img/icons/app-144.png" />
	
	<!--[if lt IE 9]>
	<script src="https://h2.slack-edge.com/ef0d/js/libs/html5shiv.js"></script>
	<![endif]-->

</head>

<body class="		">

		  			<script>
		
			var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
			if (w > 1440) document.querySelector('body').classList.add('widescreen');
		
		</script>
	
  	
	

			<nav id="site_nav" class="no_transition">

	<div id="site_nav_contents">

		<div id="user_menu">
			<div id="user_menu_contents">
				<div id="user_menu_avatar">
										<span class="member_image thumb_48" style="background-image: url('https://secure.gravatar.com/avatar/862ac481d80ecde2117ab8d49087c074.jpg?s=192&d=https%3A%2F%2Fh2.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0017-192.png')" data-thumb-size="48" data-member-id="U1DMMG9NC"></span>
					<span class="member_image thumb_36" style="background-image: url('https://secure.gravatar.com/avatar/862ac481d80ecde2117ab8d49087c074.jpg?s=72&d=https%3A%2F%2Fh2.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0017-72.png')" data-thumb-size="36" data-member-id="U1DMMG9NC"></span>
				</div>
				<h3>Signed in as</h3>
				<span id="user_menu_name">ikalu</span>
			</div>
		</div>

		<div class="nav_contents">

			<ul class="primary_nav">
				<li><a href="/home" data-qa="home"><i class="ts_icon ts_icon_home"></i>Home</a></li>
				<li><a href="/account" data-qa="account_profile"><i class="ts_icon ts_icon_user"></i>Account & Profile</a></li>
				<li><a href="/apps/manage" data-qa="configure_apps" target="_blank"><i class="ts_icon ts_icon_plug"></i>Configure Apps</a></li>
				<li><a href="/archives"data-qa="archives"><i class="ts_icon ts_icon_archive" ></i>Message Archives</a></li>
				<li><a href="/files" data-qa="files"><i class="ts_icon ts_icon_all_files clear_blue"></i>Files</a></li>
				<li><a href="/team" data-qa="team_directory"><i class="ts_icon ts_icon_team_directory"></i>Team Directory</a></li>
									<li><a href="/stats" data-qa="statistics"><i class="ts_icon ts_icon_dashboard"></i>Statistics</a></li>
													<li><a href="/customize" data-qa="customize"><i class="ts_icon ts_icon_magic"></i>Customize</a></li>
													<li><a href="/account/team" data-qa="team_settings"><i class="ts_icon ts_icon_cog_o"></i>Team Settings</a></li>
							</ul>

			
		</div>

		<div id="footer">

			<ul id="footer_nav">
				<li><a href="/is" data-qa="tour">Tour</a></li>
				<li><a href="/downloads" data-qa="download_apps">Download Apps</a></li>
				<li><a href="/brand-guidelines" data-qa="brand_guidelines">Brand Guidelines</a></li>
				<li><a href="/help" data-qa="help">Help</a></li>
				<li><a href="https://api.slack.com" target="_blank" data-qa="api">API<i class="ts_icon ts_icon_external_link small_left_margin ts_icon_inherit"></i></a></li>
								<li><a href="/pricing" data-qa="pricing">Pricing</a></li>
				<li><a href="/help/requests/new" data-qa="contact">Contact</a></li>
				<li><a href="/terms-of-service" data-qa="policies">Policies</a></li>
				<li><a href="http://slackhq.com/" target="_blank" data-qa="our_blog">Our Blog</a></li>
				<li><a href="https://slack.com/signout/2266155252?crumb=s-1468629288-08af48ad1f-%E2%98%83" data-qa="sign_out">Sign Out<i class="ts_icon ts_icon_sign_out small_left_margin ts_icon_inherit"></i></a></li>
			</ul>

			<p id="footer_signature">Made with <i class="ts_icon ts_icon_heart"></i> by Slack</p>

		</div>

	</div>
</nav>	
			<header>
			<a id="menu_toggle" class="no_transition" data-qa="menu_toggle_hamburger">
			<span class="menu_icon"></span>
			<span class="menu_label">Menu</span>
			<span class="vert_divider"></span>
		</a>
		<h1 id="header_team_name" class="inline_block no_transition" data-qa="header_team_name">
			<a href="/home">
				<i class="ts_icon ts_icon_home" /></i>
				Lighthouse Labs
			</a>
		</h1>
		<div class="header_nav">
			<div class="header_btns float_right">
				<a id="team_switcher" data-qa="team_switcher">
					<i class="ts_icon ts_icon_th_large ts_icon_inherit"></i>
					<span class="block label">Teams</span>
				</a>
				<a href="/help" id="help_link" data-qa="help_link">
					<i class="ts_icon ts_icon_life_ring ts_icon_inherit"></i>
					<span class="block label">Help</span>
				</a>
									<a href="/messages" data-qa="launch">
						<img src="https://h2.slack-edge.com/66f9/img/icons/ios-64.png" srcset="https://h2.slack-edge.com/66f9/img/icons/ios-32.png 1x, https://h2.slack-edge.com/66f9/img/icons/ios-64.png 2x" />
						<span class="block label">Launch</span>
					</a>
							</div>
				                    <ul id="header_team_nav" data-qa="team_switcher_menu">
	                        	                            <li class="active">
	                            	<a href="https://lighthouse.slack.com/home" target="https://lighthouse.slack.com/">
	                            			                            			<i class="ts_icon small ts_icon_check_circle_o active_icon s"></i>
	                            			                            				                            		<i class="team_icon small" style="background-image: url('https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-04-14/4457913877_e8a4a706c037fa9c99be_88.jpg');"></i>
		                            		                            		<span class="switcher_label team_name">Lighthouse Labs</span>
	                            	</a>
	                            </li>
	                        	                        <li id="add_team_option"><a href="https://slack.com/signin" target="_blank"><i class="ts_icon ts_icon_plus team_icon small"></i> <span class="switcher_label">Sign in to another team...</span></a></li>
	                    </ul>
	                		</div>
	
	
</header>	
	<div id="page" >

		<div id="page_contents" data-qa="page_contents" class="">

<p class="print_only">
	<strong>Created by thatmose on July 15, 2016 at 6:33 PM</strong><br />
	<span class="subtle_silver break_word">https://lighthouse.slack.com/files/thatmose/F1SA0S41J/seeds.rb</span>
</p>

<div class="file_header_container no_print"></div>

<div class="alert_container">
		<div class="file_public_link_shared alert" style="display: none;">
		
	<i class="ts_icon ts_icon_link"></i> Public Link: <a class="file_public_link" href="https://slack-files.com/T027U4K7E-F1SA0S41J-d480797e10" target="new">https://slack-files.com/T027U4K7E-F1SA0S41J-d480797e10</a>
</div></div>

<div id="file_page" class="card top_padding">

	<p class="small subtle_silver no_print meta">
		9KB Ruby snippet created on <span class="date">July 15th 2016</span>.
		This file is private.		<span class="file_share_list"></span>
	</p>

	<a id="file_action_cog" class="action_cog action_cog_snippet float_right no_print">
		<span>Actions </span><i class="ts_icon ts_icon_cog"></i>
	</a>
	<a id="snippet_expand_toggle" class="float_right no_print">
		<i class="ts_icon ts_icon_expand "></i>
		<i class="ts_icon ts_icon_compress hidden"></i>
	</a>

	<div class="large_bottom_margin clearfix">
		<pre id="file_contents"># Should have 9 users after every seed
users = [{email: &quot;grea@fake.com&quot;, username: &quot;iceman&quot;, password: &quot;test&quot;},
  {email: &quot;mav@fake.com&quot;, username: &quot;maverick&quot;, password: &quot;test&quot;},
  {email: &quot;chief@fake.com&quot;, username: &quot;john&quot;, password: &quot;test&quot;},
  {email: &quot;drake@fake.com&quot;, username: &quot;musicman&quot;, password: &quot;test&quot;},
  {email: &quot;dance@fake.com&quot;, username: &quot;smooth&quot;, password: &quot;test&quot;},
  {email: &quot;test@fake.com&quot;, username: &quot;test&quot;, password: &quot;test&quot;},
  {email: &quot;moses@fake.com&quot;, username: &quot;mose&quot;, password: &quot;test&quot;},
  {email: &quot;shino@fake.com&quot;, username: &quot;shino&quot;, password: &quot;test&quot;},
  {email: &quot;troy@fake.com&quot;, username: &quot;troy&quot;, password: &quot;test&quot;}]

books = [
      {
      user_id: 7,
      title: &quot;Tome&quot;,
      author: &quot;jose valdez&quot;,
      genre: &quot;Comic&quot;,
      available: false
   },
      {
      user_id: 3,
      title: &quot;Pride and Prejudice&quot;,
      author: &quot;liliana mosley&quot;,
      genre: &quot;Biography&quot;,
      available: true
   },
      {
      user_id: 3,
      title: &quot;Mikey&#039;s&quot;,
      author: &quot;semaj davis&quot;,
      genre: &quot;Fiction&quot;,
      available: false
   },
      {
      user_id: 7,
      title: &quot;Pride and Prejudice&quot;,
      author: &quot;shelby cole&quot;,
      genre: &quot;Comic&quot;,
      available: true
   },
      {
      user_id: 6,
      title: &quot;Poetry&quot;,
      author: &quot;nickolas hansen&quot;,
      genre: &quot;Action&quot;,
      available: true
   },
      {
      user_id: 1,
      title: &quot;Tome&quot;,
      author: &quot;francis hatfield&quot;,
      genre: &quot;Action&quot;,
      available: false
   },
      {
      user_id: 6,
      title: &quot;James Bond&quot;,
      author: &quot;kiersten buckley&quot;,
      genre: &quot;Horror&quot;,
      available: true
   },
      {
      user_id: 1,
      title: &quot;Poetry&quot;,
      author: &quot;julieta potts&quot;,
      genre: &quot;Action&quot;,
      available: true
   },
      {
      user_id: 7,
      title: &quot;Poetry&quot;,
      author: &quot;rowen ferrell&quot;,
      genre: &quot;Action&quot;,
      available: false
   }
]

posts = [
      {
      user_id: 2,
      book_id: 7,
      rating: 5,
      review: &quot;Lorem ipsum nulla parturient tortor duis accumsan placerat rutrum luctus vitae est. Lorem ipsum dis, diam curabitur dignissim pulvinar urna imperdiet sociis sociis consequat! Lorem ipsum hac augue scelerisque blandit tortor class suspendisse neque lectus integer. Lorem ipsum semper, tortor ornare parturient lacinia taciti hac rutrum interdum vestibulum! Lorem ipsum vehicula nec augue donec phasellus dictum leo himenaeos eleifend vestibulum. \\nLobortis aliquam mollis dui interdum urna fames sociosqu vel. Quisque sollicitudin etiam senectus vel euismod sed nibh volutpat? Taciti ridiculus nibh vel consequat praesent lectus non nibh. Suspendisse sed accumsan enim leo sodales elit integer lobortis? \\n&quot;
   },
      {
      user_id: 6,
      book_id: 1,
      rating: 2,
      review: &quot;Lorem ipsum sit vulputate aliquet quam class facilisi feugiat cum. Lorem ipsum nam tincidunt proin dictum facilisi sollicitudin quam taciti? Lorem ipsum nascetur faucibus cubilia lacus lacus placerat vivamus senectus. Lorem ipsum pellentesque netus parturient dignissim congue velit ad imperdiet. Lorem ipsum fermentum eros adipiscing, tempor dictum lacus dictumst eu. Lorem ipsum tincidunt nam iaculis habitant lacus, vulputate nam aliquet! \\nId porta justo lectus magnis enim mus viverra? Natoque interdum at porttitor nostra eget sapien fermentum. Potenti amet luctus vel id dolor habitant nam. Sagittis facilisi quis amet pulvinar, aptent sapien quam. Euismod nam hac erat hendrerit fames orci tellus. Quis lectus euismod nullam dictumst neque ante class. \\n&quot;
   },
      {
      user_id: 9,
      book_id: 3,
      rating: 5,
      review: &quot;Lorem ipsum rutrum duis luctus, convallis turpis neque arcu accumsan eleifend? Lorem ipsum vel iaculis lobortis maecenas fringilla tellus torquent venenatis egestas. Lorem ipsum nunc fames, habitant dolor a lacinia commodo netus lorem. Lorem ipsum adipiscing vulputate tristique dis massa, lacinia aliquam posuere neque? Lorem ipsum iaculis sagittis suspendisse est conubia dictumst risus dignissim sociosqu? \\nMagna ad dis morbi, auctor et mi iaculis laoreet turpis eros. Nullam magna donec vehicula per fusce a torquent lobortis sed semper. \\n&quot;
   },
      {
      user_id: 1,
      book_id: 1,
      rating: 3,
      review: &quot;Lorem ipsum mus maecenas donec ultrices habitasse lacus dictumst potenti cum. Lorem ipsum elementum interdum nulla lectus turpis et in ridiculus aliquet! Lorem ipsum ridiculus facilisi sem litora fermentum eros sem lobortis netus. Lorem ipsum nostra proin velit nibh sed sit eu porta suscipit. \\nTortor eu mattis rutrum odio diam iaculis arcu. Nostra malesuada pulvinar class tempor augue dapibus mus. Morbi odio varius lacinia leo cras nullam suspendisse. Sollicitudin arcu, elit dapibus faucibus arcu tristique augue. Arcu cum vulputate imperdiet, aenean tincidunt bibendum penatibus. \\n&quot;
   },
      {
      user_id: 9,
      book_id: 7,
      rating: 4,
      review: &quot;Lorem ipsum massa vehicula sed et quam condimentum convallis taciti primis felis magna. Lorem ipsum quis duis feugiat felis primis semper at cursus tellus id amet! Lorem ipsum volutpat suscipit nam nam tortor habitasse dui odio facilisis etiam metus. Lorem ipsum feugiat dui lorem nec viverra a lacus, donec tortor diam curae;? \\nNullam tempus commodo dis tincidunt tristique ac, tellus netus venenatis. Praesent velit nisl amet leo id ultrices amet adipiscing cras. Ad vivamus vivamus, primis ultricies pretium suscipit duis ridiculus ac. \\n&quot;
   },
      {
      user_id: 9,
      book_id: 8,
      rating: 4,
      review: &quot;Lorem ipsum diam dictumst dignissim porttitor in aliquam ligula erat gravida praesent pellentesque. Lorem ipsum iaculis sociosqu felis augue ut cursus quisque gravida, elit sollicitudin vivamus. Lorem ipsum cubilia enim nulla sollicitudin dis lectus ultricies nostra et litora egestas. Lorem ipsum sociosqu ornare ipsum nullam, nullam lacinia lectus ullamcorper non enim vehicula? \\nEros molestie litora primis per nascetur morbi inceptos feugiat. Congue curabitur nascetur fringilla porta sed, hendrerit taciti gravida. Tincidunt fermentum eu purus duis suscipit vivamus nisi suspendisse? Orci ligula vivamus auctor feugiat primis donec augue proin? \\n&quot;
   },
      {
      user_id: 8,
      book_id: 2,
      rating: 4,
      review: &quot;Lorem ipsum ultrices neque ante nam diam litora condimentum diam lobortis velit. Lorem ipsum quis porttitor venenatis, aliquam vehicula sociosqu congue sed nunc id. \\nDiam phasellus ornare metus pretium dis libero dapibus cursus. Luctus dapibus nullam penatibus suspendisse nisl per pharetra rutrum. Posuere mus maecenas ipsum faucibus ac ut elementum vivamus. Suscipit dis magna maecenas aliquam lorem aliquam taciti rhoncus. Parturient magnis, mauris adipiscing ullamcorper pretium iaculis tempor hac. \\n&quot;
   },
      {
      user_id: 1,
      book_id: 2,
      rating: 5,
      review: &quot;Lorem ipsum diam senectus nunc consequat diam quisque viverra sed mollis. Lorem ipsum sapien cursus velit tincidunt rhoncus fermentum rutrum suscipit nullam? Lorem ipsum per, purus lacinia ornare porta risus consectetur mollis auctor. \\nAt nec velit cursus lobortis mauris condimentum hac massa lectus mauris. Cursus blandit ullamcorper porta turpis accumsan libero orci hac primis metus. Feugiat vivamus volutpat urna lorem etiam sagittis hendrerit lorem iaculis suspendisse! Nec nisi vel aptent facilisi non integer ultrices eleifend est sollicitudin? \\n&quot;
   },
      {
      user_id: 4,
      book_id: 7,
      rating: 5,
      review: &quot;Lorem ipsum facilisis malesuada potenti arcu velit vitae mi sociis torquent elementum posuere netus? Lorem ipsum consectetur consectetur sem laoreet rhoncus sed feugiat platea pulvinar et himenaeos elementum. Lorem ipsum risus conubia at nunc, aenean viverra porta dignissim felis volutpat sit tempus. Lorem ipsum nascetur donec tellus mattis curabitur gravida parturient quisque mattis ad rhoncus ligula! Lorem ipsum iaculis neque nulla mollis convallis justo et nisi amet, tortor nunc dictumst. Lorem ipsum cum sociis libero condimentum rhoncus leo in leo odio at semper integer! \\nSuspendisse eleifend felis torquent aliquet in quam consequat egestas pharetra. Placerat ligula integer eget nostra litora quis hac class tellus. Egestas scelerisque viverra ultricies auctor commodo rutrum sollicitudin massa sociosqu. \\n&quot;
   }
]

pictures = [
      {
      book_id: 3,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 8,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 3,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 5,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 9,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 8,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 9,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 7,
      url: &quot;http://placehold.it/300x250&quot;
   },
      {
      book_id: 7,
      url: &quot;http://placehold.it/300x250&quot;
   }
]

users.each do |user|
  User.create(user)
end

books.each do |book|
  Book.create(book)
end

posts.each do |post|
  Post.create(post)
end

pictures.each do |picture|
  Picture.create(picture)
end</pre>

		<p class="file_page_meta no_print" style="line-height: 1.5rem;">
			<label class="checkbox normal mini float_right no_top_padding no_min_width">
				<input type="checkbox" id="file_preview_wrap_cb"> wrap long lines
			</label>
		</p>

	</div>

	<div id="comments_holder" class="clearfix clear_both">
	<div class="col span_1_of_6"></div>
	<div class="col span_4_of_6 no_right_padding">
		<div id="file_page_comments">
			<div class="loading_hash_animation">
	<img src="https://h2.slack-edge.com/f85a/img/loading_hash_animation_@2x.gif" srcset="https://h2.slack-edge.com/272a/img/loading_hash_animation.gif 1x, https://h2.slack-edge.com/f85a/img/loading_hash_animation_@2x.gif 2x" alt="Loading" class="loading_hash" /><br />loading...
	<noscript>
		You must enable javascript in order to use Slack :(
				<style type="text/css">div.loading_hash { display: none; }</style>
	</noscript>
</div>		</div>	
		<form action="https://lighthouse.slack.com/files/thatmose/F1SA0S41J/seeds.rb"
		id="file_comment_form"
					class="comment_form"
				method="post">
			<a href="/team/ikalu" class="member_preview_link" data-member-id="U1DMMG9NC" >
			<span class="member_image thumb_36" style="background-image: url('https://secure.gravatar.com/avatar/862ac481d80ecde2117ab8d49087c074.jpg?s=72&d=https%3A%2F%2Fh2.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0017-72.png')" data-thumb-size="36" data-member-id="U1DMMG9NC"></span>
		</a>
		<input type="hidden" name="addcomment" value="1" />
	<input type="hidden" name="crumb" value="s-1468629288-4fe02cdee4-☃" />

	<textarea id="file_comment" data-el-id-to-keep-in-view="file_comment_submit_btn" class="small comment_input small_bottom_margin autogrow-short" name="comment" wrap="virtual" ></textarea>
	<span class="input_note float_left cloud_silver file_comment_tip">shift+enter to add a new line</span>	<button id="file_comment_submit_btn" type="submit" class="btn float_right  ladda-button" data-style="expand-right"><span class="ladda-label">Add Comment</span></button>
</form>

<form
		id="file_edit_comment_form"
					class="edit_comment_form hidden"
				method="post">
		<textarea id="file_edit_comment" class="small comment_input small_bottom_margin" name="comment" wrap="virtual"></textarea><br>
	<span class="input_note float_left cloud_silver file_comment_tip">shift+enter to add a new line</span>	<input type="submit" class="save btn float_right " value="Save" />
	<button class="cancel btn btn_outline float_right small_right_margin ">Cancel</button>
</form>	
	</div>
	<div class="col span_1_of_6"></div>
</div>
</div>



		
	</div>
	<div id="overlay"></div>
</div>





<script type="text/javascript">
var cdn_url = "https:\/\/slack.global.ssl.fastly.net";
var inc_js_setup_data = {
	emoji_sheets: {
		apple: 'https://h2.slack-edge.com/f360/img/emoji_2016_06_08/sheet_apple_64_indexed_256colors.png',
		google: 'https://h2.slack-edge.com/f360/img/emoji_2016_06_08/sheet_google_64_indexed_128colors.png',
		twitter: 'https://h2.slack-edge.com/f360/img/emoji_2016_06_08/sheet_twitter_64_indexed_128colors.png',
		emojione: 'https://h2.slack-edge.com/f360/img/emoji_2016_06_08/sheet_emojione_64_indexed_128colors.png',
	},
};
</script>
			<script type="text/javascript">
<!--
	// common boot_data
	var boot_data = {
		start_ms: Date.now(),
		app: 'web',
		user_id: 'U1DMMG9NC',
		no_login: false,
		version_ts: '1468628382',
		version_uid: '901e8a70e4f724a534a838d5727d4015d6f55f3c',
		cache_version: "v13-tiger",
		cache_ts_version: "v1-cat",
		redir_domain: 'slack-redir.net',
		signin_url: 'https://slack.com/signin',
		abs_root_url: 'https://slack.com/',
		api_url: '/api/',
		team_url: 'https://lighthouse.slack.com/',
		image_proxy_url: 'https://slack-imgs.com/',
		beacon_timing_url: "https:\/\/slack.com\/beacon\/timing",
		beacon_error_url: "https:\/\/slack.com\/beacon\/error",
		clog_url: "clog\/track\/",
		api_token: 'xoxs-2266155252-47735553760-56683453250-1c9f4f61b8',
		ls_disabled: false,

		notification_sounds: [{"value":"b2.mp3","label":"Ding","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/b2.mp3"},{"value":"animal_stick.mp3","label":"Boing","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/animal_stick.mp3"},{"value":"been_tree.mp3","label":"Drop","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/been_tree.mp3"},{"value":"complete_quest_requirement.mp3","label":"Ta-da","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/complete_quest_requirement.mp3"},{"value":"confirm_delivery.mp3","label":"Plink","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/confirm_delivery.mp3"},{"value":"flitterbug.mp3","label":"Wow","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/flitterbug.mp3"},{"value":"here_you_go_lighter.mp3","label":"Here you go","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/here_you_go_lighter.mp3"},{"value":"hi_flowers_hit.mp3","label":"Hi","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/hi_flowers_hit.mp3"},{"value":"item_pickup.mp3","label":"Yoink","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/item_pickup.mp3"},{"value":"knock_brush.mp3","label":"Knock Brush","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/knock_brush.mp3"},{"value":"save_and_checkout.mp3","label":"Woah!","url":"https:\/\/slack.global.ssl.fastly.net\/dfc0\/sounds\/push\/save_and_checkout.mp3"},{"value":"none","label":"None"}],
		alert_sounds: [{"value":"frog.mp3","label":"Frog","url":"https:\/\/slack.global.ssl.fastly.net\/a34a\/sounds\/frog.mp3"}],
		call_sounds: [{"value":"call\/alert_v2.mp3","label":"Alert","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/alert_v2.mp3"},{"value":"call\/incoming_ring_v2.mp3","label":"Incoming ring","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/incoming_ring_v2.mp3"},{"value":"call\/outgoing_ring_v2.mp3","label":"Outgoing ring","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/outgoing_ring_v2.mp3"},{"value":"call\/pop_v2.mp3","label":"Incoming reaction","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/pop_v2.mp3"},{"value":"call\/they_left_call_v2.mp3","label":"They left call","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/they_left_call_v2.mp3"},{"value":"call\/you_left_call_v2.mp3","label":"You left call","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/you_left_call_v2.mp3"},{"value":"call\/they_joined_call_v2.mp3","label":"They joined call","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/they_joined_call_v2.mp3"},{"value":"call\/you_joined_call_v2.mp3","label":"You joined call","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/you_joined_call_v2.mp3"},{"value":"call\/confirmation_v2.mp3","label":"Confirmation","url":"https:\/\/slack.global.ssl.fastly.net\/08f7\/sounds\/call\/confirmation_v2.mp3"}],
		call_sounds_version: "v2",
		max_team_handy_rxns: 5,
		max_channel_handy_rxns: 5,
		max_poll_handy_rxns: 7,
		max_handy_rxns_title_chars: 30,
		
		feature_tinyspeck: false,
		feature_create_team_google_auth: false,
		feature_api_extended_2fa_backup: false,
		feature_rtm_start_over_ms: false,
		feature_emoji_usage_stats: false,
		feature_beacon_dom_node_count: true,
		feature_message_replies: false,
		feature_message_replies_simple: false,
		feature_no_rollups: false,
		feature_web_lean: false,
		feature_web_lean_all_users: false,
		feature_reminders_v3: true,
		feature_all_skin_tones: false,
		feature_import_batch_actions: false,
		feature_server_side_emoji_counts: true,
		feature_a11y_keyboard_shortcuts: false,
		feature_email_ingestion: false,
		feature_msg_consistency: false,
		feature_sli_channel_priority: false,
		feature_sli_similar_channels: false,
		feature_emoji_keywords: false,
		feature_thanks: false,
		feature_attachments_inline: false,
		feature_billing_netsuite: true,
		feature_fix_files: true,
		feature_files_list: true,
		feature_channel_eventlog_client: true,
		feature_macssb1_banner: true,
		feature_macssb2_banner: true,
		feature_latest_event_ts: true,
		feature_elide_closed_dms: true,
		feature_no_redirects_in_ssb: true,
		feature_referer_policy: true,
		feature_more_field_in_message_attachments: false,
		feature_calls: true,
		feature_calls_no_rtm_start: true,
		feature_integrations_message_preview: true,
		feature_paging_api: false,
		feature_enterprise_dashboard: true,
		feature_enterprise_api: true,
		feature_enterprise_create: true,
		feature_enterprise_api_auth: true,
		feature_enterprise_profile: true,
		feature_enterprise_search: true,
		feature_enterprise_team_invite: true,
		feature_enterprise_locked_settings: false,
		feature_enterprise_search_ui: false,
		feature_private_channels: true,
		feature_mpim_restrictions: false,
		feature_subteams_hard_delete: false,
		feature_no_unread_counts: true,
		feature_js_raf_queue: false,
		feature_shared_channels: false,
		feature_shared_channels_ui: false,
		feature_external_shared_channels_ui: false,
		feature_batch_users: false,
		feature_updated_channel_options_flow: false,
		feature_manage_shared_channel_teams: false,
		feature_shared_channels_settings: false,
		feature_fast_files_flexpane: true,
		feature_no_has_files: true,
		feature_custom_saml_signin_button_label: true,
		feature_optimistic_im_close: false,
		feature_admin_approved_apps: true,
		feature_winssb_beta_channel: false,
		feature_inline_video: false,
		feature_developers_lp: true,
		feature_clog_whats_new: false,
		feature_upload_file_switch_channel: true,
		feature_live_support: true,
		feature_dm_yahself: true,
		feature_slackbot_goes_to_college: false,
		feature_popover_dismiss_only: true,
		feature_attachment_actions: true,
		feature_shared_invites: true,
		feature_lato_2_ssb: true,
		feature_refactor_buildmsghtml: false,
		feature_reduce_files_page_size: true,
		feature_allow_cdn_experiments: false,
		feature_omit_localstorage_users_bots: false,
		feature_disable_ls_compression: false,
		feature_sign_in_with_slack: true,
		feature_sign_in_with_slack_ui_elements: true,
		feature_indigenous_scroll: true,
		feature_indigenous_scroll_batch_2: true,
		feature_prevent_msg_rebuild: false,
		feature_app_review_part_2: false,
		feature_new_app_modal: false,
		feature_app_directory_tos: true,
		feature_app_directory_search_solr: false,
		feature_name_tagging_client: false,
		feature_msg_input_contenteditable: false,
		feature_browse_date: true,
		feature_use_imgproxy_resizing: false,
		feature_events_api_frontend: false,
		feature_update_message_file: false,
		feature_custom_clogs: true,
		feature_channels_view_introspect_messages: false,
		feature_intercept_format_copy: false,
		feature_calls_linux: true,
		feature_emoji_hover_styles: true,
		feature_emoji_speed: true,
		feature_a11y_preference: false,
		feature_share_mention_comment_cleanup: false,
		feature_search_menu: true,
		feature_unread_view: false,
		feature_tw: false,
		feature_tw_ls_disabled: false,
		feature_external_files: false,
		feature_channel_info_pins_and_guests: false,
		feature_min_web: false,
		feature_electron_memory_logging: false,
		feature_limit_jl_rollups: true,
		feature_jumper_open_state: true,
		feature_jumper_archived_channels: true,
		feature_optimize_mentions_stars_paging: true,
		feature_simple_file_events: true,
		feature_empty_flexpanes: true,
		feature_backend_frecency_validation: false,
		feature_backend_frecency_pruning: false,
		feature_devrel_try_it_now: false,
		feature_defer_history: true,
		feature_wait_for_all_mentions_in_client: false,
		feature_free_inactive_domains: false,
		feature_invitebulk_method_in_modal: false,
		feature_invite_modal_refresh: false,
		feature_slackbot_feels: true,
		feature_platform_calls: false,
		feature_a11y_tab: false,
		feature_admin_billing_refactor: false,

		img: {
			app_icon: 'https://h2.slack-edge.com/272a/img/slack_growl_icon.png'
		},
		page_needs_custom_emoji: false,
		page_needs_team_profile_fields: false,
		page_needs_enterprise: false,
		slackbot_help_enabled: true
	};

	
	
	
	
	// client boot data
	
	
//-->
</script>	
	
				<!-- output_js "core" -->
<script type="text/javascript" src="https://h2.slack-edge.com/3e1f/js/rollup-core_required_libs.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/4f1f/js/rollup-core_required_ts.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/ad781/js/TS.web.js" crossorigin="anonymous"></script>

		<!-- output_js "core_web" -->
<script type="text/javascript" src="https://h2.slack-edge.com/1665/js/rollup-core_web.js" crossorigin="anonymous"></script>

		<!-- output_js "secondary" -->
<script type="text/javascript" src="https://h2.slack-edge.com/c832c/js/rollup-secondary_a_required.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/b25d/js/rollup-secondary_b_required.js" crossorigin="anonymous"></script>

					
	<!-- output_js "regular" -->
<script type="text/javascript" src="https://h2.slack-edge.com/8e19/js/TS.web.comments.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/e3fe4/js/TS.web.file.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/5183/js/libs/codemirror.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://h2.slack-edge.com/e826/js/codemirror_load.js" crossorigin="anonymous"></script>

		<script type="text/javascript">
	<!--
		boot_data.page_needs_custom_emoji = true;

		boot_data.file = {"id":"F1SA0S41J","created":1468629215,"timestamp":1468629215,"name":"seeds.rb","title":"seeds.rb","mimetype":"text\/plain","filetype":"ruby","pretty_type":"Ruby","user":"U1DPD1127","editable":true,"size":9198,"mode":"snippet","is_external":false,"external_type":"","is_public":false,"public_url_shared":false,"display_as_bot":false,"username":"","url_private":"https:\/\/files.slack.com\/files-pri\/T027U4K7E-F1SA0S41J\/seeds.rb","url_private_download":"https:\/\/files.slack.com\/files-pri\/T027U4K7E-F1SA0S41J\/download\/seeds.rb","permalink":"https:\/\/lighthouse.slack.com\/files\/thatmose\/F1SA0S41J\/seeds.rb","permalink_public":"https:\/\/slack-files.com\/T027U4K7E-F1SA0S41J-d480797e10","edit_link":"https:\/\/lighthouse.slack.com\/files\/thatmose\/F1SA0S41J\/seeds.rb\/edit","preview":"# Should have 9 users after every seed\nusers = [{email: \"grea@fake.com\", username: \"iceman\", password: \"test\"},\n  {email: \"mav@fake.com\", username: \"maverick\", password: \"test\"},\n  {email: \"chief@fake.com\", username: \"john\", password: \"test\"},\n  {email: \"drake@fake.com\", username: \"musicman\", password: \"test\"},","preview_highlight":"\u003Cdiv class=\"CodeMirror cm-s-default CodeMirrorServer\"\u003E\n\u003Cdiv class=\"CodeMirror-code\"\u003E\n\u003Cdiv\u003E\u003Cpre\u003E\u003Cspan class=\"cm-comment\"\u003E# Should have 9 users after every seed\u003C\/span\u003E\u003C\/pre\u003E\u003C\/div\u003E\n\u003Cdiv\u003E\u003Cpre\u003E\u003Cspan class=\"cm-variable\"\u003Eusers\u003C\/span\u003E \u003Cspan class=\"cm-operator\"\u003E=\u003C\/span\u003E [{\u003Cspan class=\"cm-atom\"\u003Eemail:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;grea@fake.com&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Eusername:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;iceman&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Epassword:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;test&quot;\u003C\/span\u003E},\u003C\/pre\u003E\u003C\/div\u003E\n\u003Cdiv\u003E\u003Cpre\u003E  {\u003Cspan class=\"cm-atom\"\u003Eemail:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;mav@fake.com&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Eusername:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;maverick&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Epassword:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;test&quot;\u003C\/span\u003E},\u003C\/pre\u003E\u003C\/div\u003E\n\u003Cdiv\u003E\u003Cpre\u003E  {\u003Cspan class=\"cm-atom\"\u003Eemail:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;chief@fake.com&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Eusername:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;john&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Epassword:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;test&quot;\u003C\/span\u003E},\u003C\/pre\u003E\u003C\/div\u003E\n\u003Cdiv\u003E\u003Cpre\u003E  {\u003Cspan class=\"cm-atom\"\u003Eemail:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;drake@fake.com&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Eusername:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;musicman&quot;\u003C\/span\u003E, \u003Cspan class=\"cm-atom\"\u003Epassword:\u003C\/span\u003E \u003Cspan class=\"cm-string\"\u003E&quot;test&quot;\u003C\/span\u003E},\u003C\/pre\u003E\u003C\/div\u003E\n\u003C\/div\u003E\n\u003C\/div\u003E\n","lines":188,"lines_more":183,"channels":[],"groups":["G1REFV0SG"],"ims":[],"comments_count":1,"initial_comment":{"id":"Fc1SAN46EN","created":1468629215,"timestamp":1468629215,"user":"U1DPD1127","is_intro":true,"comment":"Seed file\/ put in db folder","channel":""}};
		boot_data.file.comments = [{"id":"Fc1SAN46EN","created":1468629215,"timestamp":1468629215,"user":"U1DPD1127","is_intro":true,"comment":"Seed file\/ put in db folder","channel":""}];

		

		var g_editor;

		$(function(){

			var wrap_long_lines = !!TS.model.code_wrap_long_lines;

			g_editor = CodeMirror(function(elt){
				var content = document.getElementById("file_contents");
				content.parentNode.replaceChild(elt, content);
			}, {
				value: $('#file_contents').text(),
				lineNumbers: true,
				matchBrackets: true,
				indentUnit: 4,
				indentWithTabs: true,
				enterMode: "keep",
				tabMode: "shift",
				viewportMargin: Infinity,
				readOnly: true,
				lineWrapping: wrap_long_lines
			});

			$('#file_preview_wrap_cb').bind('change', function(e) {
				TS.model.code_wrap_long_lines = $(this).prop('checked');
				g_editor.setOption('lineWrapping', TS.model.code_wrap_long_lines);
			})

			$('#file_preview_wrap_cb').prop('checked', wrap_long_lines);

			CodeMirror.switchSlackMode(g_editor, "ruby");
		});

		
		$('#file_comment').css('overflow', 'hidden').autogrow();
	//-->
	</script>

			<script type="text/javascript">TS.boot(boot_data);</script>
	
<style>.color_9f69e7:not(.nuc) {color:#9F69E7;}.color_4bbe2e:not(.nuc) {color:#4BBE2E;}.color_e7392d:not(.nuc) {color:#E7392D;}.color_3c989f:not(.nuc) {color:#3C989F;}.color_674b1b:not(.nuc) {color:#674B1B;}.color_e96699:not(.nuc) {color:#E96699;}.color_e0a729:not(.nuc) {color:#E0A729;}.color_684b6c:not(.nuc) {color:#684B6C;}.color_5b89d5:not(.nuc) {color:#5B89D5;}.color_2b6836:not(.nuc) {color:#2B6836;}.color_99a949:not(.nuc) {color:#99A949;}.color_df3dc0:not(.nuc) {color:#DF3DC0;}.color_4cc091:not(.nuc) {color:#4CC091;}.color_9b3b45:not(.nuc) {color:#9B3B45;}.color_d58247:not(.nuc) {color:#D58247;}.color_bb86b7:not(.nuc) {color:#BB86B7;}.color_5a4592:not(.nuc) {color:#5A4592;}.color_db3150:not(.nuc) {color:#DB3150;}.color_235e5b:not(.nuc) {color:#235E5B;}.color_9e3997:not(.nuc) {color:#9E3997;}.color_53b759:not(.nuc) {color:#53B759;}.color_c386df:not(.nuc) {color:#C386DF;}.color_385a86:not(.nuc) {color:#385A86;}.color_a63024:not(.nuc) {color:#A63024;}.color_5870dd:not(.nuc) {color:#5870DD;}.color_ea2977:not(.nuc) {color:#EA2977;}.color_50a0cf:not(.nuc) {color:#50A0CF;}.color_d55aef:not(.nuc) {color:#D55AEF;}.color_d1707d:not(.nuc) {color:#D1707D;}.color_43761b:not(.nuc) {color:#43761B;}.color_e06b56:not(.nuc) {color:#E06B56;}.color_8f4a2b:not(.nuc) {color:#8F4A2B;}.color_902d59:not(.nuc) {color:#902D59;}.color_de5f24:not(.nuc) {color:#DE5F24;}.color_a2a5dc:not(.nuc) {color:#A2A5DC;}.color_827327:not(.nuc) {color:#827327;}.color_3c8c69:not(.nuc) {color:#3C8C69;}.color_8d4b84:not(.nuc) {color:#8D4B84;}.color_84b22f:not(.nuc) {color:#84B22F;}.color_4ec0d6:not(.nuc) {color:#4EC0D6;}.color_e23f99:not(.nuc) {color:#E23F99;}.color_e475df:not(.nuc) {color:#E475DF;}.color_619a4f:not(.nuc) {color:#619A4F;}.color_a72f79:not(.nuc) {color:#A72F79;}.color_7d414c:not(.nuc) {color:#7D414C;}.color_aba727:not(.nuc) {color:#ABA727;}.color_965d1b:not(.nuc) {color:#965D1B;}.color_4d5e26:not(.nuc) {color:#4D5E26;}.color_dd8527:not(.nuc) {color:#DD8527;}.color_bd9336:not(.nuc) {color:#BD9336;}.color_e85d72:not(.nuc) {color:#E85D72;}.color_dc7dbb:not(.nuc) {color:#DC7DBB;}.color_bc3663:not(.nuc) {color:#BC3663;}.color_9d8eee:not(.nuc) {color:#9D8EEE;}.color_8469bc:not(.nuc) {color:#8469BC;}.color_73769d:not(.nuc) {color:#73769D;}.color_b14cbc:not(.nuc) {color:#B14CBC;}</style>

<!-- slack-www1105 / 2016-07-15 17:34:48 / v901e8a70e4f724a534a838d5727d4015d6f55f3c / B:P -->

</body>
</html>