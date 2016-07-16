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
        body: options.body
    };
    console.log(params);
    return NativeSimpleFetch.sendRequest(params).then((res)=> {
        console.log(res);
        const statusCode = parseInt(res[0]);
        const body = res[1];
        return {
            ok: statusCode >= 200 && statusCode <= 300,
            status: statusCode,
            json: ()=> {
                return new Promise((resolve, reject)=> {
                    try {
                        let obj = JSON.parse(body);
                        resolve(obj);
                    } catch (e) {
                        if (typeof body === 'string') {
                            resolve(body);
                        }
                        else {
                            reject(e);
                        }
                    }
                });
            }
        };
    }, (err)=> {
        console.log(err);
        return err;
    });
};

module.exports = {
    fetch
};