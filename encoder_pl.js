const readline = require('readline');
const fs = require('fs');

function match_regex(regex, text) {
    return text.match(regex)
}

function text_to_code(text) {
    let buffer_text = Buffer.from(text);
    var code_str = '';

    for (var i = 0; i < buffer_text.length; i++)
    {
        code_str += buffer_text[i].toString(16);
    }

    return code_str;
}

function code_to_text(code) {
    var buf = Buffer.alloc(code.length/2);
    for (var i = 0; i < code.length/2; i++)
    {
        var str = code[i*2] + code[i*2 + 1];
        buf[i] = parseInt(str, 16);
    }
    return buf.toString('utf8');
}

async function delete_content_encoding_file(filename) {
    return new Promise(resolve => {
        if (filename.slice(-10, -3) == 'encoded')
        {
            fs.writeFile(filename, '', function(err, data){
                if (err) console.log(err);
                console.log(`Successfully Deleted Content: ${filename}`);
                resolve();
            });
        }
    });
}

async function creating_encoding_file(filename) {
    return new Promise(resolve => {
        var file_encoded = '';
        const rl = readline.createInterface({
            input: fs.createReadStream(filename),
            crlfDelay: Infinity
        });

        rl.on('line', (line) => {
            var str = line;

            if (match_regex(/\[.*\]/g, str) != null)
            {
                const regex = /([\w]|[^\u0000-\u007F])+/g;
                const words = match_regex(regex, str);

                for (var index in words)
                {
                    str = str.replace(words[index], `'${text_to_code(words[index])}'`)
                }
            }

            file_encoded += str + '\n';
        });

        rl.on('close', () => {
            if (filename.slice(-10, -3) != 'encoded')
            {
                var filename_encoded = filename.slice(0, -3);
                filename_encoded = `${filename_encoded}_encoded.pl`;
                file_encoded = file_encoded.slice(0, -1); /* Remove last character : \n. */
                fs.writeFile(filename_encoded, file_encoded, function(err, data){
                    if (err) console.log(err);
                    console.log(`Successfully Encoded: ${filename_encoded}`);
                    resolve();
                });
            }
        });
    });
}

async function main() {
    const args = process.argv.slice(2);

    if(args[0] == '-d' || args[0] == '-delete')
    {
        fs.readdir(args[1], (err, files) => {
            files.forEach(async file => {
                delete_content_encoding_file(`${args[1]}/${file}`);
            });
        })
    }
    else if(args[0] == '-e' || args[0] == '-encode')
    {
        fs.readdir(args[1], (err, files) => {
            files.forEach(async file => {
                creating_encoding_file(`${args[1]}/${file}`);
            });
        })
    }
    else if(args[0] == '-h' || args[0] == undefined)
    {
        console.log("Please fill the arguments to begin encoding.");
        console.log("node encoder_pl.js -e ./tuvung");
        console.log("node encoder_pl.js -d ./tuvung");
    }
}

main()