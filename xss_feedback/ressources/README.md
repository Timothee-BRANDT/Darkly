## Cross-Site Scripting (XSS) Exploit

XSS exploit is a type of security vulnerability typically found in web applications. It allows attackers to inject malicious scripts into web pages viewed by other users. These scripts can then execute in the victim’s browser, potentially leading to the theft of sensitive information, such as session cookies, or even the takeover of user accounts.

## XSS Feedback Exploit

There is a page at `http://127.0.0.1:8080/?page=feedback` with a feedback form that contains a `name` and `message` field. This form is vulnerable to an XSS attack. Specifically, the vulnerability arises because the application does not properly sanitize the input in the `name` field, allowing attackers to insert malicious scripts.

In this case, you just need to enter the word `script` (as if it were a real malicious script) in the `name` field to receive the flag:

`0fbb54bbf7d099713ca4be297e1bc7da0173d8b3c21c1811b916a3a86652724e`

## Prevention

- **Input Validation:** Always validate and sanitize user inputs. Ensure that input data is checked against expected patterns and reject or escape any potentially harmful characters.
- **Output Encoding:** Encode user input before displaying it on a web page. This ensures that characters like <, >, and & are treated as text rather than executable code.
- **Content Security Policy (CSP):** Implement a Content Security Policy to control the sources from which scripts can be loaded. This reduces the risk of unauthorized script execution.
- **Sanitization Libraries:** Use sanitization libraries such as DOMPurify or OWASP Java Encoder to clean user-generated content. These tools are specifically designed to strip out or neutralize potentially malicious code.
- **Web Application Firewall (WAF):** Employ a Web Application Firewall to monitor and filter incoming traffic. WAFs can detect and block malicious requests, adding an additional layer of defense against XSS.
- **Secure Frameworks:** Develop your application using web frameworks that provide built-in protection against XSS, such as automatic output encoding and input validation.
- **HTTPOnly and SameSite Cookies:** Use the HTTPOnly and SameSite attributes for cookies to prevent client-side scripts from accessing them and to mitigate certain types of XSS and CSRF attacks.

## Resources

- [OWASP XSS (Cross-Site Scripting) Explanation](https://owasp.org/www-community/attacks/xss/)
- [OWASP Cross-Site Scripting Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
- [Defending Against Cross-Site Scripting (XSS) Attacks: Techniques and Strategies](https://medium.com/@ahmedgomaa_45441/defending-against-cross-site-scripting-xss-attacks-techniques-and-strategies-a7dead42d1ea)
