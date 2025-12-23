const sharp = require("sharp");
const fs = require("fs").promises;
const path = require("path");

(async () => {
  const dir = "./img";
  const outdir = "./sharp-output";
  const files = await fs.readdir(dir);
  console.log(`== Apply sharp rotate(null) to files in directory ${dir} and save to ${outdir} ==`);

  for (const file of files) {
    const inputPath = path.join(dir, file);
    const outputPath = path.join(outdir, file + ".sharp.rotate.jpg");
    console.log(`Sharp rotate: ${file} -> ${outputPath}`);
    try {
      await sharp(inputPath).rotate(null).jpeg({ quality: 80 }).toFile(outputPath);
    } catch (err) {
      console.log(`[-] Error: ${file}:`, err);
    }
  }
})();
