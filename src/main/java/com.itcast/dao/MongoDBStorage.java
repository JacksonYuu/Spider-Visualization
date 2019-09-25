package com.itcast.dao;

import com.itcast.util.ReadFile;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;

public class MongoDBStorage {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private MongoClient mongoClient = null;

    /**
     * 构造方法
     */
    public static MongoDBStorage instance;

    public static synchronized MongoDBStorage getInstance() {
        if (instance == null) {
            instance = new MongoDBStorage();
        }
        return instance;
    }

    /**
     * 解析配置信息
     * @return
     */
    public HashMap<String, String> analyseConfiguration() {

        HashMap<String, String> map = new HashMap<>();

        //读取配置文件信息
        String path = "D:\\IntelliJ IDEA 2018.2.4-workspace\\example\\configuration\\mongodb.json";

        String file = ReadFile.readFile(path);

        JSONObject jsonObject = new JSONObject(file);

        //添加信息
        map.put("server_ip", jsonObject.getString("server_ip"));

        map.put("server_port", jsonObject.getString("server_port"));

        //返回信息
        return map;
    }

    /**
     * 初始化连接
     * @return 连接
     */
    public MongoClient init() {

        //得到配置信息
        MongoDBStorage mongoDBStorage = MongoDBStorage.getInstance();

        HashMap<String, String> map = mongoDBStorage.analyseConfiguration();

        String ip = map.get("server_ip");

        Integer port = Integer.parseInt(map.get("server_port"));

        //创建mongodb数据库的连接
        mongoClient = new MongoClient(ip, port);

        logger.debug("MongoDB Connection Successful!");

        return mongoClient;
    }

    /**
     * 关闭连接
     */
    public void close() {

        if (mongoClient != null) {

            mongoClient.close();
        }
    }

    /**
     * 创建集合并连接
     * @param mongoClient 数据库连接
     * @param database 数据库名称
     * @param collection 集合名称
     * @return
     */
    public MongoCollection<Document> createCollection(MongoClient mongoClient, String database, String collection) {
        try {

            //连接到数据库
            MongoDatabase mongoDatabase = mongoClient.getDatabase(database);

            logger.debug("MongoDB Database Connection Successful!");

            //连接到集合
            MongoCollection<Document> mongoCollection = mongoDatabase.getCollection(collection);

            logger.debug("MongoDB Collection Connection Successful!");

            return mongoCollection;
        } catch (Exception e) {

            logger.debug("Not found here!");

            logger.error(e.toString());

            return null;
        }
    }

    /**
     * 连接数据库和集合
     * @param mongoClient 连接数据库
     * @param database 数据库名称
     * @param collection 集合名称
     * @return MongoCursor<Document> 游标
     */
    public MongoCursor<Document> connectCollection(MongoClient mongoClient, String database, String collection) {
        try {

            //连接到数据库
            MongoDatabase mongoDatabase = mongoClient.getDatabase(database);

            logger.debug("MongoDB Database Connection Successful!");

            //连接到集合
            MongoCollection<Document> mongoCollection = mongoDatabase.getCollection(collection);

            logger.debug("MongoDB Collection Connection Successful!");

            //获取迭代器
            FindIterable<Document> findIterable = mongoCollection.find();

            //获取游标
            MongoCursor<Document> mongoCursor = findIterable.iterator();

            return mongoCursor;
        } catch (Exception e) {

            logger.debug("Not found here!");

            logger.error(e.toString());

            return null;
        }
    }
}
