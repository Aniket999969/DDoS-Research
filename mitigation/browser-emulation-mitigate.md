# Elimitating the threat of Browser Emulation attacks

We will use [Cookie based DDoS mitigation](#Links) to eliminate this threat.

#### Using TestCookie Expiration : 

```testcookie expires 20m;```

We will expire the cookie every 20M to stop DDoS attacks incase an attacker uses Cookie Hijacking 

We can additonally use ```testcookie_session $remote_addr;```  to use client's IP as user unique identifier

#### Using Encryption to eliminate cookie hijacking

```    testcookie_redirect_via_refresh on;
    testcookie_refresh_encrypt_cookie on;
    testcookie_refresh_encrypt_cookie_key random; #will generate randomly on each restart
    testcookie_refresh_encrypt_cookie_iv random; #will generate randomly on each restart
    testcookie_refresh_template '<html><body>setting cookie...<script type=\"text/javascript\" src=\"/aes.min.js\" ></script><script>function toNumbers(d){var e=[];d.replace(/(..)/g,function(d){e.push(parseInt(d,16))});return e}function toHex(){for(var d=[],d=1==arguments.length&&arguments[0].constructor==Array?arguments[0]:arguments,e="",f=0;f<d.length;f++)e+=(16>d[f]?"0":"")+d[f].toString(16);return e.toLowerCase()}var a=toNumbers({use your favorite JS obfuscator to hide key value here}),b=toNumbers({use your favorite JS obfuscator to hide key value here}),c=toNumbers("$testcookie_enc_set");document.cookie="BPC="+toHex(slowAES.decrypt(c,2,a,b))+"; expires=Thu, 31-Dec-37 23:55:55 GMT; path=/";location.href="$testcookie_nexturl";</script></body></html>';
```

Now a browser emulation script cannot decrypt the encrypted cookie.

## Some good measures

``` 
testcookie_max_attempts 3; 
testcookie_arg ckattempt;
testcookie_httponly_flag on;
```

# Warning!

This solution will protect you from most attacks! but cannot guarantee protection against all the attacks!

We may change some settings or techniques as per user feedbacks.

# Links
[Javascript Challenge](https://nginx-extras.getpagespeed.com/modules/js-challenge/)

[Cookie Based DDoS Mitigation](https://nginx-extras.getpagespeed.com/modules/testcookie/)