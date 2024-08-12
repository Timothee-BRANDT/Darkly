# htpasswd

When using `dirb` to scan for hidden files or folders, you can run the following command:

```sh
dirb http://127.0.0.1:8080/
```

In the results, you might see something like this:

```sh
+ http://127.0.0.1:8080/robots.txt (CODE:200|SIZE:53)
---- Entering directory: http://127.0.0.1:8080/whatever/ ----
+ http://127.0.0.1:8080/whatever/htpasswd (CODE:200|SIZE:38)
```

The `robots.txt` file is used to communicate with web crawlers and search engine robots, instructing them on which parts of a website should not be crawled or indexed. Placed in the root directory of a website, this file contains directives like Disallow, which prevents crawlers from accessing specified paths. For example in our the `robots.txt` file contains:

```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```

Navigating to the link `http://127.0.0.1:8080/whatever/`, you'll find the `htpasswd` file, which contains:

```
root:437394baff5aa33daa618be47b75cb49 
```

If we decode the MD5 hash `437394baff5aa33daa618be47b75cb49`, we obtain the password `qwerty123@`.

Continuing with the dirb scan, we also see:

```
---- Entering directory: http://127.0.0.1:8080/admin/ ----                                                                                                                                          
+ http://127.0.0.1:8080/admin/index.php (CODE:200|SIZE:1432)
```

Visiting `http://127.0.0.1:8080/admin/index.php`, you can enter `root` as the username and `qwerty123@` as the password.

Upon successful login, you will receive the flag:

`d19b4823e0d5600ceed56d5e896ef328d7a2b9e7ac7e80f4fcdb9b10bcb3e7ff`

## Prevention

- **Remove Sensitive Files from Public Access:** Ensure files like `.htpasswd` are stored outside the web root or protected to prevent unauthorized access.

- **Use a noindex Robots Meta Tag on Sensitive Pages:** Add the following `<meta>` tag with noindex to the `<head>` section of HTML pages that should not be indexed by search engines:

```html
<meta name="robots" content="noindex, nofollow">
```

- **Implement X-Robots-Tag Header in HTTP Responses:** Configure your server to include the X-Robots-Tag HTTP header in responses for pages or resources that should not be indexed or followed. This provides an additional layer of control by instructing search engines to disregard the content, regardless of the meta tags present in the HTML. This method is useful for non-HTML content, such as PDFs or other files, where embedding meta tags is not possible. This can be set in the server configuration or `.htaccess` file:

```apache
<IfModule mod_headers.c>
Header set X-Robots-Tag "noindex, nofollow"
</IfModule>
```

## Resources

- [How to Address Security Risks with Robots.txt Files](https://www.searchenginejournal.com/robots-txt-security-risks/289719/)
- [Balise meta robots](https://robots-txt.com/meta-robots/)
- [En-tête HTTP X-Robots-Tag](https://robots-txt.com/x-robots-tag/)
