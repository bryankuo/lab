#ifndef MONGO_H
#define MONGO_H

#include <mongocxx/client.hpp>
#include <mongocxx/uri.hpp>

#include <QObject>

#include "info.h"

#define WRITE2_DB_
class Mongo : public QObject
{
    Q_OBJECT
public:
    Mongo();
    ~Mongo();
    int64_t connect(void);
    int64_t connectPool(void);
    int64_t disconnect(void);
    int64_t create(Info* p_info);
    int64_t createDoc(Info* p_info, string& to_doc);

signals:

public slots:
private:    
    std::string m_user;
    std::string m_pass;
    std::string m_host;
    std::string m_db;
    std::string m_collection;
    int32_t m_port;

    mongocxx::uri m_uri;
    mongocxx::client m_client;
/*
    //mongocxx::instance m_inst;
    mongocxx::options::client m_client_options;
*/
};

#endif // MONGO_H
