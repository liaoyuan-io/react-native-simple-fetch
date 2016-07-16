/**
 * Created by tshen on 16/7/15.
 */
'use strict'

import {NativeModules} from 'react-native';
const NativeSimpleFetch = NativeModules.SimpleFetch;

const fetch = function (url, options) {
    const params = {
        url: url,
        method: options.method ? options.method.toUpperCase() : 'GET',
        headers: options.headers,
        timeout: 10000,
        body: options.body,
        gzipRequest: true
    };

    return NativeSimpleFetch.sendRequest(params).then((res)=> {
        const status = parseInt(res[0]);
        const body = res[1];
        return {
            ok: status >= 200 && status < 300,
            status: status,
            json: ()=> {
                return new Promise((resolve, reject)=> {
                    try {
                        let obj = JSON.parse(body);
                        resolve(obj);
                    } catch (e) {
                        reject(e);
                    }
                });
            },
            text: ()=> {
                return Promise.resolve(body);
            }
        };
    });
};

module.exports = {
    fetch
};