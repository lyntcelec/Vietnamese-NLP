'use strict';

function text_to_code(text) {
    let buffer_text = Buffer.from(text);
    var code_str = '';

    for (var i = 0; i < buffer_text.length; i++)
    {
        code_str += buffer_text[i].toString(16);
    }

    return code_str;
}

function strtext_to_strcode(text) {
    var split_words = text.split(" ");
    var strcode = '';

    for (var index in split_words)
    {
        strcode += text_to_code(split_words[index]) + ' ';
    }
    strcode = strcode.slice(0, -1);
    return strcode;
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

function strcode_to_strtext(strcode) {
    var split_words = strcode.split(" ");
    var strtext = '';

    for (var index in split_words)
    {
        strtext += code_to_text(split_words[index]) + ' ';
    }
    strtext = strtext.slice(0, -1);
    return strtext;
}

async function main() {
    const args = process.argv.slice(2);
    if (args[0] == '-c2t')
    {
        console.log(strcode_to_strtext(args[1]));
    }
    if (args[0] == '-t2c')
    {
        console.log(strtext_to_strcode(args[1]));
    }
    if (args[0] == '-h')
    {
        console.log(`node convert.js -t2c "xin chào"`);
        console.log(`node convert.js -c2t "78696e 6368c3a06f"`);
    }
}

main()