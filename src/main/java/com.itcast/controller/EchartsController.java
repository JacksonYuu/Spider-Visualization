package com.itcast.controller;

import com.itcast.dao.MongoDBStorage;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import net.sf.json.JSONObject;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import sun.plugin2.message.Message;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/getData")
public class EchartsController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @RequestMapping("/province")
    public void provinceData(HttpServletResponse httpServletResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        List<String> nameList = new ArrayList<>();

        List<String> valueList = new ArrayList<>();

        MongoDBStorage mongoDBStorage = MongoDBStorage.getInstance();

        MongoClient mongoClient = mongoDBStorage.init();

        String database = "job_cloud";

        String collection = "job_province_distribution";

        MongoCursor<Document> cursor = mongoDBStorage.connectCollection(mongoClient, database, collection);

        while (cursor.hasNext()) {

            Document document = cursor.next();

            List<Document> documentList= (List<Document>) document.get("category");

            for (int i = 0; i < documentList.size(); i++) {

                Document document1 = documentList.get(i);

                String name = document1.getString("name");

                String value = String.valueOf(document1.getInteger("number"));

                nameList.add(name);

                valueList.add(value);
            }
        }

        map.put("nameList", nameList);

        map.put("valueList", valueList);

        JSONObject jsonObject = JSONObject.fromObject(map);

        httpServletResponse.setContentType("text/html;charset=UTF-8");

        httpServletResponse.getWriter().print(jsonObject);
    }

    @RequestMapping("/education")
    public void education(HttpServletResponse httpServletResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        List<String> nameList = new ArrayList<>();

        List<String> valueList = new ArrayList<>();

        MongoDBStorage mongoDBStorage = MongoDBStorage.getInstance();

        MongoClient mongoClient = mongoDBStorage.init();

        String database = "job_cloud";

        String collection = "job_education_distribution";

        MongoCursor<Document> cursor = mongoDBStorage.connectCollection(mongoClient, database, collection);

        while (cursor.hasNext()) {

            Document document = cursor.next();

            List<Document> documentList= (List<Document>) document.get("category");

            for (int i = 0; i < documentList.size(); i++) {

                Document document1 = documentList.get(i);

                String name = document1.getString("type");

                String value = String.valueOf(document1.getInteger("number"));

                nameList.add(name);

                valueList.add(value);
            }
        }

        map.put("nameList", nameList);

        map.put("valueList", valueList);

        JSONObject jsonObject = JSONObject.fromObject(map);

        httpServletResponse.setContentType("text/html;charset=UTF-8");

        httpServletResponse.getWriter().print(jsonObject);
    }
}
