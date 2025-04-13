---
sidebar_position: 1
---

# Tản mạn

## Concept System Design
### Database
Một Database Transaction, theo như định nghĩa sẽ phải thỏa mãn các tính chất sau: Atomic, Consistency, Isolation và Durable (hay thường được gọi là ACID). Bài viết này sẽ tập trung vào tính chất Consistency.

#### Sharding 
Cách tách database và lưu trữ, có thể tách thành 4 con server như sau:

Database 1: lưu các users có ID chia cho 4 dư 1 (mod). Ví dụ 1, 5, 9, 13, …
Database 2: lưu các users có ID chia cho 4 dư 2. Ví dụ 2, 6, 10, 14, …
Database 3: lưu các users có ID chia cho 4 dư 3. Ví dụ 3, 7, 11, 15, …
Database 4: lưu các users có ID chia cho 4 dư 0. Ví dụ 4, 8, 12, 16, …
Bây giờ, vấn đề làm sao để generate ID cho user khi họ register đây ta? Làm sao biết user nào lưu vào database nào? Đây là ID Generator ở trong hình đó bạn

Bạn lại trằn trọc suy nghĩ, vì bạn là thiên tài nên sau 1 đêm bạn đã suy nghĩ ra là. À hay là mình tạo ra một hash function để hash user email lại và generate ID ra ta.

Và ý tưởng của bạn như sau (code dưới là ví dụ thôi nhoa):

```Java
class IdGenerator {
    // Method này dùng để sinh ra một unique ID ứng với email của user.
    public static int generateUserId(String email) 
                                    throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(
                               email.getBytes(StandardCharsets.UTF_8));
        
        return Math.abs(new BigInteger(1, hashBytes).intValue());
    }

    // Method này dùng để get server ID. 
    // Từ đó sẽ biết user nào cần được lưu trữ ở đâu.
    public static int generateServerId(int userId) {
        return userId % 4;
    }
}
```

Bây giờ khi user đăng ký tài khoản, bạn chỉ cần lấy email của user rồi đưa vào IdGenerator là xong.

```Java
// Giả sử email đang là "anhLiem@gmail.com";
int userId = IdGenerator.generateUserId(email); // Kết quả ra 16129187
int serverId = IdGenerator.generateServerId(userId); // Kết quả ra 3
```
Vậy là bạn đã biết anh Liêm lưu ở server thứ 3.

#### Consistency
`Distributed Database` (hệ thống cơ sở dữ liệu phân tán): Là hệ thống Cơ sở dữ liệu (CSDL) mà có thể được phân tải, lưu trữ ở nhiều nơi.      

`Strong Consistency` (tính nhất quán mạnh): Một cập nhật được diễn ra và trả về trạng thái success khi các node trong distributed database đều được cập nhật.         
Ví dụ: Khi một ông user A nào đó thực hiện ghi dữ liệu (trên hình là ghi X=100 vào node 1). Và ông A này thấy lệnh ghi dữ liệu thành công (ví dụ response 200 OK). Thì ngay lập tức có 2 ông B và C đọc dữ liệu X ngay ở node 2 và node 3. Và họ thấy X=100 luôn. Đây chính là strong consistency. Dữ liệu được sync đồng bộ qua các node. Không có chuyện là ông A ghi thành công rồi, và ông C get X ra thì not found.
  
`Eventual Consistency` (tính nhất quán cuối cùng, là một dạng của tính nhất quán yếu - Weak Consistency): Sau khi một cập nhật được diễn ra, các lần đọc sau đó không đảm bảo sẽ luôn trả về giá trị mới được cập nhật (có thể có lần đọc vẫn trả về dữ liệu cũ). Tuy nhiên sau một khoảng thời gian (đồng bộ giữa các CSDL) thì cuối cùng các lần đọc đều trả về giá trị mới nhất.       
Ví dụ: Trong bối cảnh mới này, X=100 đã được ghi thành công ở node 1. Sau đó được sync ngay qua node 2 và node 3. Và lúc này ông B đọc node 2 thì thấy kết quả 100. Nhưng ông C đọc node 3 thì not found. Và ông B thấy lạ liền gọi điện chửi ông A, chú lưu dữ liệu chưa sao anh không tìm thấy? Ông A nói, ủa anh em mới lưu xong rồi đó, anh check lại dùm em. Thế là ông B lay hoay refresh lại thì thấy kết quả 100.        

#### Câu chuyện đánh đổi giữa tính consistency và high availability
Trong thế giới distributed database, mọi thứ không bao giờ là hoàn hảo. Bản thân các bạn là software engineer. Và nhiệm vụ của các bạn là phân tích nghiệp vụ của sản phẩm mình đang phát triển và giải quyết các bài toán trade-off này.     

Trong phần này, mình sẽ cùng bạn đi giải quyết bài toán đánh đổi giữa availability và consistency.

Có bạn sẽ thắc mắc! Thế tại sao chúng ta không chọn cả 2 ông availability và consistency luôn? Mà phải đắn đo suy nghĩ để lựa chọn một trong hai?

Cùng quay lại bài toán strong consistency hồi nảy xíu!

Nhìn vào sequence diagram, bạn sẽ thấy, lệnh write để thành công được đòi hỏi tất cả các node phải thành công. Nghĩa là client lúc này phải chờ để write 3 node. Lúc này latency (thời gian response) của request write X sẽ cao hơn rất nhiều. Vậy thì nếu nhiều request hàng loạt ập tới, khả năng các node sẽ tạch cao hơn rất nhiều. Và kết quả dẫn tới low availability.

Chốt lại là. Muốn strong consistency thì phải đánh đổi bởi availability.

Tiếp tục với bài toán eventual consistency. Latency của request write X lúc này rất nhỏ. Vì chỉ cần ghi thành công node 1 là coi như request thành công. Có thể hiểu đơn giản latency lúc nảy giảm tối thiểu gấp 3 lần so với trường hợp strong consistency. Latency nhỏ dẫn tới các node sẽ chịu tải được nhiều hơn (high availability). Nhưng lúc này đánh đổi bởi consistency. Data sẽ được sync qua các node tốn một thời gian nhất định. Cho nên đôi khi client read X sẽ chỉ thấy được data cũ. Và đôi khi không sync được data qua các node dẫn tới tình trạng inconsistency.

`Chốt lại là. Muốn high availability thì phải đánh đổi với consistency.`   

Đây cũng chính CAP theorem huyền thoại mà chúng ta hay nghe thấy.

Vậy thì, đối với từng business cụ thể, chúng ta sẽ phải suy nghĩ và lựa chọn trade-off ở đây.

Mình lấy ví dụ, một trang social hay báo điện tử (như 24h chẳng hạn). Có thể chọn high availability thay vì chọn strong consistency. Những business liên quan tới tiền bạc thì có thể chọn strong consistency. Túm lại là tùy thuộc vào business của từng application cụ thể. Bạn và team bạn sẽ phải planning và lựa chọn.   




`Reference:`   
https://tech.cybozu.vn/su-khoi-dau-cho-system-design-nang-tam-backend-developer-phan-1-f631d/
https://tech.cybozu.vn/su-khoi-dau-cho-system-design-nang-tam-backend-developer-phan-2-84974/     