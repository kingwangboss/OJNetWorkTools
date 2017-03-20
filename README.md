# OJNetWorkTools
网络请求工具


pod 'OJNetWorkTools', '~> 1.0.1'

<pre><code>
//使用get请求
[[OJNetWorkTools shareRequestData] requestDataURL:urlStr parameters:dict method:GET success:^(NSData *data, NSURLResponse *response) {
NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
NSLog(@"%@",dict);

} fail:^(NSError *error) {

}];
</code></pre>

<pre><code>
//直接解析json
[[OJNetWorkTools shareRequestData] requestDataURL:urlStr parameters:dict method:POST dataFormat:JSON success:^(id data, NSURLResponse *response) {
NSLog(@"%@",data);
} fail:^(NSError *error) {

}];
</code></pre>
