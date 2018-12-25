'use strict';
const swipl             = require('swipl');
const readline          = require('readline');
const rl                = readline.createInterface(process.stdin, process.stdout);
const net               = require('net');
const { spawn }         = require("child_process");
const JsonFind          = require('json-find');

swipl.call('consult(main)');
//spawn('python3.7', ['prolog_interface_server.py']);

var client;
var json_parser = [];

var loai_danh_tu = [
    'danhtu_ten',
    'danhtu_rieng',
    'danhtu_chicaycoi',
    'danhtu_chidovat',
    'danhtu_chiconvat',
    'danhtuchung_demduoc',
    'danhtu_khongdemduoc'
];


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

/**
 * Input command line.
 *
 * @param {string} prompt.
 * @param {callback}{string} handler.
 */
function promptInput(prompt, handler) {
    rl.question(prompt, input => {
        if (handler(input) !== false) {
            promptInput(prompt, handler);
        }
        else {
            rl.close();
        }
    });
}

function call_prolog(pl_cmd_input) {
    client.write(pl_cmd_input);
}

function cau_cau_khien_processing(json_parser) {
    console.log(`cau_cau_khien_processing`);
    console.log(JSON.stringify(json_parser));

    var dong_tu;
    var danh_tu;
    var cumtu_dacbiet;
    const doc = JsonFind(json_parser);

    dong_tu = doc.checkKey('dongtu_chihanhdong');
    console.log(`dong_tu: ${strcode_to_strtext(dong_tu)}`);

    cumtu_dacbiet = doc.checkKey('cumtu_dacbiet');

    danh_tu = doc.checkKey('cum_danh_tu');
    const doc_danh_tu = JsonFind(danh_tu);
    danh_tu = false;
    for (var i in loai_danh_tu)
    {
        var danh_tu_tmp = doc_danh_tu.checkKey(loai_danh_tu[i]);

        if (danh_tu_tmp != false)
        {
            danh_tu = strcode_to_strtext(danh_tu_tmp);

            break;
        }
    }

    if (cumtu_dacbiet != false)
    {
        console.log(`cumtu_dacbiet: ${strcode_to_strtext(cumtu_dacbiet)}`);
    }

    if (danh_tu != false)
    {
        console.log(`danh_tu: ${danh_tu}`);
    }
}

function processing_parser(json_parser) {
    var cumtu_dacbiet_shortest_parser = null;
    var cumtu_dacbiet_length = 10000;


    for (var index in json_parser)
    {
        const doc = JsonFind(json_parser[index]);
        console.log(`${index} :===================>`);
        console.log(JSON.stringify(json_parser[index]))

        const cumtu_dacbiet_tmp = doc.checkKey('cumtu_dacbiet');
        if(cumtu_dacbiet_tmp != false)
        {
            if (cumtu_dacbiet_tmp.length < cumtu_dacbiet_length)
            {
                cumtu_dacbiet_length = cumtu_dacbiet_tmp.length;
                cumtu_dacbiet_shortest_parser = json_parser[index];
            }
        }
        else
        {
            cau_cau_khien_processing(json_parser[index]);
        }

    }

    if (cumtu_dacbiet_shortest_parser != null)
    {
        cau_cau_khien_processing(cumtu_dacbiet_shortest_parser);
    }
}

setTimeout(function() {
    client = new net.Socket();
    client.connect(3344, '127.0.0.1', function() {
        console.log('Connected');
    });

    client.on('close', function() {
        console.log('Connection closed');
    });

    client.on('data', function(data) {
        var json_string = data.toString('utf8');
        const check_Finish = json_string.slice(-6, json_string.length);

        if( json_string.length > check_Finish.length)
        {
            if(check_Finish == 'Finish')
            {
                json_string = json_string.slice(0, -check_Finish.length);
            }
            json_string = json_string.replace(/'/g, "\"");
            json_parser.push(JSON.parse(json_string));
        }

        if(check_Finish == 'Finish')
        {
            var json_parser_tmp = json_parser;
            json_parser = [];
            processing_parser(json_parser_tmp);
        }
    });
}, 300);

async function main() {
    const args = process.argv.slice(2);

    promptInput('Command > ', async input => {
        if (input != '')
        {
            var pl_cmd_input = 'cau([';
            var split_words = input.split(" ");
            for (var index in split_words)
            {
                pl_cmd_input += `'${text_to_code(split_words[index])}',`;
            }
            pl_cmd_input = pl_cmd_input.slice(0, -1);
            pl_cmd_input = pl_cmd_input.toLowerCase();
            pl_cmd_input += "], [], P)";
            call_prolog(pl_cmd_input);
        }


    });
}

/*
maika ơi mở bài lạc trôi đi

 */
main()