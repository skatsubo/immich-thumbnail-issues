const sharp = require("sharp");
const fs = require("fs").promises;
const path = require("path");

(async () => {
  const dir = "img";
  const files = await fs.readdir(dir);
  console.log(`[*] Test sharp resize in directory: ${dir}`);

  for (const file of files) {
    const inputPath = path.join(dir, file);
    const outputPath = path.join("/tmp", file + ".sharp.resize.jpg");
    console.log(`[*] Resize: ${file} -> ${outputPath} ...`);
    try {
      await sharp(inputPath).resize(100, 100, { fit: "inside" }).jpeg({ quality: 80 }).toFile(outputPath);
      console.log(`[+] Ok: ${file}`);
    } catch (err) {
      console.log(`[-] Error: ${file}:`, err);
    }
  }
})();
