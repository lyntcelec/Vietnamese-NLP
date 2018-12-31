'use strict';

var text_in = '{"cau_cau_khien":{"caucaukhien_xulytrungtam":{"dong_tu":{"loai_dongtu":{"dongtu_chihanhdong":"6de1bb9f"}},"cho":"63686f","cum_danh_tu1":{"dai_tu":{"daitu_nhanxung_ngoithunhat":"74c3b469"}},"cum_danh_tu2":{"danh_tu":{"bai":"62c3a069","cache_nhac":"6ce1baa163 7472c3b469"}}},"photu_cuoicau":"c49169","caucaukhien_daitu":{"danhtu_ten":"6d61696b61","camtu_oi":"c6a169"}}}'


function match_regex(regex, text) {
    return text.match(regex)
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

function decode_json_string(json_str) {
    const regex = /(\:\"(\w+)\")|(\:\"(\w+\s){1,}\w+\")/g;
    const words = match_regex(regex, json_str);

    for (var i in words)
    {
        words[i] = words[i].slice(2, words[i].length);
        words[i] = words[i].slice(0, -1);
        json_str = json_str.replace(words[i], strcode_to_strtext(words[i]));
    }
    return json_str;
}

async function main() {
    console.log(decode_json_string(text_in))
}

main()