# XSS Exploit

## Overview

By clicking the "Leave a Feedback" button at the bottom of the homepage, users are redirected to a page where a feedback form can be filled out.

A potential XSS vulnerability could be exploited using the "Name" or "Message" fields of this form. XSS attacks involve code injection, similar to SQL injection, but in this case, the attacker injects malicious code through client-side input parameters.

## Executing the Exploit

To demonstrate the existence of the XSS vulnerability, we can inject malicious code into the "Name" field. However, this input field is initially limited to 10 characters, so we must modify the character limit in the HTML/CSS to allow for longer input.

### Step 1: Modify the Character Limit

The character limit for the input fields can be extended to 1000 characters by modifying the HTML of the form.

**Original code:**
```html
<input name="txtName" type="text" size="30" maxlength="10">
```

**Modified code:**
```html
<input name="txtName" type="text" size="30" maxlength="1000">
```

This allows us to input longer strings, which are necessary for the XSS attack.

### Step 2: Inject Malicious Code

Once the character limit is increased, you can test the vulnerability by injecting one of the two payloads into the "Name" field. Each of them should trigger a JavaScript `alert`, proving that the XSS vulnerability exists. There may be more payloads that can also exploit this vulnerability, but the following are confirmed to work:

1. Using an SVG:
    ```html
    <svg/onload=alert("42")>
    ```

2. Using an object with Base64-encoded content where "PHNjcmlwdD5hbGVydCgnNDInKTwvc2NyaXB0Pg==" is `<script>alert('42')</script>` in Base64:
    ```html
    <object data="data:text/html;base64,PHNjcmlwdD5hbGVydCgnNDInKTwvc2NyaXB0Pg=="/>
    ```

### Step 3: Verifying the Exploit

The verification mechanism for this vulnerability appears to be broken. Using one of these two specific payloads, we were able to trigger an alert, confirming that the page is vulnerable to XSS attacks, but the tag does not appear visually.

Finally, by injecting the most basic alert `<script>alert("42")</script>` into the "Name" field without extending the input character limits, the page will reveal the flag:

`0fbb54bbf7d099713ca4be297e1bc7da0173d8b3c21c1811b916a3a86652724e`

## Prevention

To mitigate XSS vulnerabilities, the following best practices should be implemented:

- **Encoding Output:** Encode user-controlled data in HTTP responses to prevent it from being interpreted as active content. Use appropriate encoding methods based on context, such as HTML, URL, JavaScript, or CSS encoding.
- **Input Validation:** Sanitize user inputs by validating and escaping special characters. Ensure that input fields only accept expected data types (e.g., alphanumeric characters).
- **Use Appropriate Response Headers:** Set proper HTTP headers like Content-Type and X-Content-Type-Options to control how browsers interpret your responses, preventing unintended HTML or JavaScript execution.

## Resources

- [Cross Site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/)
- [XSS Filter Evasion Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html)
- [The Ultimate Beginners Guide to XSS Vulnerability](https://brightsec.com/blog/cross-site-scripting-xss/)
- [Preventing XSS attacks](https://portswigger.net/web-security/cross-site-scripting/preventing)
