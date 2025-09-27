const sharp = require("sharp");
const fs = require("fs").promises;
const path = require("path");

(async () => {
  const dir = "img";
  const files = await fs.readdir(dir);
  console.log(`[*] Test sharp operations in directory: ${dir}`);

  for (const file of files) {
    const inputPath = path.join(dir, file);
    console.log(`[*] toBuffer: ${file} ...`);
    try {
      const { data, info } = await sharp(inputPath).raw().toBuffer({ resolveWithObject: true });
      console.log(`[+] Ok: ${file}: ${data.length} bytes, ${info.width}x${info.height}x${info.channels}`);
    } catch (err) {
      console.log(`[-] Error: ${file}:`, err);
    }
  }
})();
