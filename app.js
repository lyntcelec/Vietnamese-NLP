const readline = require('readline');
const fs = require('fs');
const path = require('path');

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

async function main() {
    const args = process.argv.slice(2);
    console.log(text_to_code('mở'))
    console.log(text_to_code('bài'))
    console.log(text_to_code('lạc'))
    console.log(text_to_code('trôi'))
}

main()