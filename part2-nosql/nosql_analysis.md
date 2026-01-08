## Section A: Limitations of RDBMS

Traditional relational databases such as MySQL or PostgreSQL are not well suited for handling highly diverse product catalogs like those required by FlexiMart. In a relational model, all products must conform to a fixed table schema. This becomes problematic when different product categories have different attributes, such as laptops requiring RAM and processor details, while shoes require size and color. Supporting such diversity would require either many nullable columns or multiple related tables, increasing complexity.

Additionally, relational databases are rigid when it comes to schema evolution. Introducing new product types or attributes often requires ALTER TABLE operations, which are expensive and risky in large production systems. Frequent schema changes reduce system agility and increase maintenance overhead.

Storing customer reviews also poses challenges in an RDBMS. Reviews naturally fit a nested structure within products, but relational databases require separate review tables and JOIN operations. This leads to performance overhead, complex queries, and difficulty in retrieving product data along with its reviews efficiently.

## Section B: NoSQL Benefits (MongoDB)

MongoDB addresses the limitations of relational databases by using a flexible, document-based data model. Each product can be stored as a JSON-like document, allowing different products to have different attributes without enforcing a fixed schema. This makes MongoDB ideal for handling diverse product categories such as electronics, clothing, and accessories within the same collection.

MongoDB also supports embedded documents, enabling customer reviews to be stored directly within the product document. This improves read performance by eliminating the need for complex joins and allows product data and reviews to be retrieved together in a single query.

Furthermore, MongoDB is designed for horizontal scalability. It supports sharding, which allows data to be distributed across multiple servers as the product catalog grows. This ensures high availability and performance, making MongoDB suitable for large-scale e-commerce platforms like FlexiMart where data volume and variety increase rapidly.


## Section C: Trade-offs of MongoDB

While MongoDB offers flexibility and scalability, it also has certain disadvantages compared to relational databases. One major drawback is the lack of strong relational integrity. MongoDB does not enforce foreign key constraints, which can lead to data inconsistency if relationships are not carefully managed at the application level.

Another trade-off is that MongoDB is not ideal for complex transactional operations requiring strong ACID guarantees across multiple entities. For scenarios involving complex joins, financial transactions, or strict consistency requirements, relational databases like MySQL may be more suitable than MongoDB.



