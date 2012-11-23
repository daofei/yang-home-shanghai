# -*- coding: utf-8 -*-
# 是否使用ini作为配置文件，0不使用
ini_config = 1353657174
# 监听ip
listen_ip = '127.0.0.1'
# 监听端口
listen_port = 8086
# 是否使用通配符证书
cert_wildcard = 1
# 更新PAC时也许还没联网，等待tasks_delay秒后才开始更新
tasks_delay = 0
# WEB界面是否对本机也要求认证
web_authlocal = 0
# 登录WEB界面的用户名
web_username = 'admin'
# 登录WEB界面的密码
web_password = 'admin'
# 全局代理
global_proxy = None
# URLFetch参数
fetch_keepalive = 1

def config():
    Forward, set_dns, set_hosts, check_auth, redirect_https = import_from('util')
    FORWARD = Forward()
    set_dns('8.8.8.8')
    google_sites = ('.appspot.com', '.googlecode.com', '.googleusercontent.com', '.googlegroups.com', 'ssl.google-analytics.com')
    google_hosts = 'www.google.com mail.google.com 74.125.128.45 74.125.128.32 74.125.128.65 74.125.128.114 74.125.128.51 74.125.128.54 74.125.128.199 74.125.128.84 74.125.128.59 74.125.128.50 74.125.128.104 74.125.128.35 74.125.128.61 74.125.128.154 74.125.128.142 74.125.128.31 74.125.128.156 74.125.128.19 74.125.128.96 74.125.128.117'
    set_hosts(google_sites, google_hosts)
    set_hosts('.youtube.com@443', google_hosts)
    set_hosts('www.google.com code.google.com mail.google.com .mail.google.com groups.google.com maps.google.com mts0.google.com mts1.google.com news.google.com play.google.com video.google.com drive.google.com appengine.google.com chrome.google.com .url.google.com talkgadget.google.com clients2.google.com', google_hosts)
    set_hosts('.youtube.com@80', '203.208.46.1 203.208.46.2 203.208.46.3 203.208.46.4 203.208.46.5 203.208.46.6 203.208.46.7 203.208.46.8 203.208.47.1 203.208.47.2 203.208.47.3 203.208.47.4 203.208.47.5 203.208.47.6 203.208.47.7 203.208.47.8 203.208.47.160 203.208.47.161 203.208.47.162 203.208.47.163 203.208.47.164 203.208.47.165 203.208.47.166 203.208.47.167')

    from plugins import paas; paas = install('paas', paas)
    GAE = paas.GAE(appids=['yangyun0123456'], listen='8087', path='/fetch.py', scheme='https', hosts=google_hosts, maxsize=500000, waitsize=100000, max_threads=3, fetch_mode=1)

    PacFile, RuleList = import_from('pac')
    forcehttps_sites = RuleList('http://*.google.com/ \n http://www.google.com.hk/ \n http://*.googlecode.com/ \n http://*.googleusercontent.com/ \n http://developer.android.com/ \n @@http://books.google.com/ \n @@http://translate.google.com/ \n @@http://scholar.google.com/ \n @@http://www.google.com*/imgres? \n @@http://www.google.com*/translate_t?')
    autorange_rules = RuleList('||c.youtube.com \n ||c.docs.google.com \n ||googlevideo.com \n http*://av.vimeo.com/ \n http*://smile-*.nicovideo.jp/ \n http*://video.*.fbcdn.net/ \n http*://s*.last.fm/ \n http*://x*.last.fm/ \n /^https?:\\/\\/[^\\/]+\\/[^?]+\\.(?:f4v|flv|hlv|m4v|mp4|mp3|ogg|avi|exe)(?:$|\\?)/')
    _GAE = GAE; GAE = lambda req: _GAE(req, autorange_rules.match(req.url, req.proxy_host[0]))
    import re; useragent_match = re.compile('(?i)mobile').search
    useragent_rules = RuleList('||twitter.com')
    withgae_sites = RuleList('||plus.google.com \n ||apis.google.com \n ||c.docs.google.com \n ||autoproxy-gfwlist.googlecode.com \n ||translate.google.com')
    hosts_rules = RuleList('/^https?:\\/\\/(?:www|code|mail|[^\\/]+\\.mail|groups|maps|mts0|mts1|news|play|video|drive|appengine|chrome|[^\\/]+\\.url|talkgadget|clients2)\\.google\\.com\\// \n /^https?:\\/\\/[^\\/]+\\.c\\.youtube\\.com\\/liveplay\\?/ \n /^https?:\\/\\/upload\\.youtube\\.com\\// \n /^https?:\\/\\/www\\.youtube\\.com\\/upload\\// \n ||appspot.com \n ||googlecode.com \n ||googleusercontent.com \n ||googlegroups.com \n ||ssl.google-analytics.com')
    FORWARD.http_failed_handler = GAE

    rulelist = (
        (RuleList(['https://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt', 'userlist.ini']), GAE),
    )
    httpslist = (
        (rulelist[0][0], None),
    )
    unparse_netloc = import_from(install('utils', lambda:globals().update(vars(utils))))

    def find_gae_handler(req):
        proxy_type = req.proxy_type
        if proxy_type.endswith('http'):
            host, port = req.proxy_host
            url = req.url
            if proxy_type != 'https2http' and forcehttps_sites.match(url, host) and req.content_length == 0:
                return redirect_https
            if useragent_match(req.headers.get('User-Agent','')) and useragent_rules.match(url, host):
                req.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4'
            if withgae_sites.match(url, host):
                return GAE
            if hosts_rules.match(url, host):
                return FORWARD
            return GAE
    paas.data['GAE_server'].find_handler = find_gae_handler

    def find_proxy_handler(req):
        proxy_type = req.proxy_type
        host, port = req.proxy_host
        if proxy_type.endswith('http'):
            url = req.url
            if proxy_type != 'https2http' and forcehttps_sites.match(url, host) and req.content_length == 0:
                return redirect_https
            if useragent_match(req.headers.get('User-Agent','')) and useragent_rules.match(url, host):
                req.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4'
            if withgae_sites.match(url, host):
                return GAE
            if hosts_rules.match(url, host):
                return FORWARD
            for rule,target in rulelist:
                if rule.match(url, host):
                    return target
            return FORWARD
        elif proxy_type.endswith('https'):
            url = 'https://%s/' % unparse_netloc((host, port), 443)
            for rule,target in httpslist:
                if rule.match(url, host):
                    return target
            return FORWARD
    return find_proxy_handler
