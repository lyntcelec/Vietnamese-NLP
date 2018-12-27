'use strict';

var json_string = '{"cau_cau_khien":{"dong_tu":{"loai_dongtu":{"dongtu_chihanhdong":"6de1bb9f"}},"cho":"63686f","cum_danh_tu":{"dai_tu":{"daitu_nhanxung_ngoithunhat":"74c3b469"}},"dong_tu":{"loai_dongtu":{"dongtu_chihanhdong":"6e676865"}},"cum_danh_tu":{"mao_tu":{"loai_maotu":"62c3a069"},"cumtu_dacbiet":"6ce1baa163 7472c3b469"}}}'

function match_regex(regex, text) {
    return text.match(regex)
}

async function convert_valid_json(json_str) {
    function counting_words_in_json(json_str, word) {
        return new Promise(resolve => {
            const regex = /([a-z|_])+":/g;
            const words = match_regex(regex, json_str);
            var count = 0;
            for (var index in words)
            {
                words[index] = words[index].slice(0, -2);
                if (words[index] === word)
                {
                    count++;
                }
            }
            resolve(count);
        });
    }

    const regex = /([a-z|_])+":/g;
    const words = match_regex(regex, json_str);
    for (var index in words)
    {
        words[index] = words[index].slice(0, -2);
        const counting_words = await counting_words_in_json(json_str, words[index]);
        if (counting_words > 1)
        {
            for (var i = 0; i < counting_words; i++)
            {
                const regex = new RegExp(`\\b${words[index]}\\b`);
                json_str = json_str.replace(regex, `${words[index]}${i+1}`);
            }
        }
    }
    return json_str
}

async function main() {
    console.log(await convert_valid_json(json_string));
}

main()