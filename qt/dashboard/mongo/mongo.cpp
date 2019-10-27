#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>

#include <QDateTime>
#include <QDebug>

#include <bsoncxx/json.hpp>
#include <bsoncxx/builder/basic/document.hpp>
#include <bsoncxx/builder/basic/kvp.hpp>
#include <bsoncxx/stdx/make_unique.hpp>
#include <bsoncxx/builder/stream/document.hpp>

#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/logger.hpp>

#include "info.h"
#include "mongo.h"

using namespace std;

#if 1
namespace {
class logger final : public mongocxx::logger {
   public:
    explicit logger(std::ostream* stream) : _stream(stream) {}

    void operator()(mongocxx::log_level level,
                    bsoncxx::stdx::string_view domain,
                    bsoncxx::stdx::string_view message) noexcept override {
        if (level >= mongocxx::log_level::k_trace)
            return;
        *_stream << '[' << mongocxx::to_string(level) << '@' << domain << "] " << message << '\n';
    }

   private:
    std::ostream* const _stream;
};
}
#endif

// c++ 3.3.x c 1.13.0
Mongo::Mongo()
    :m_user{"root"}, m_pass{"123456"},m_host{"172.16.0.181"},
    m_db{"racev"}, m_collection{"car_0001"}, m_port(27017)
{
    qDebug() << "Mongo() +";
    // The mongocxx::instance constructor and destructor initialize and shut down the driver,
    // respectively. Therefore, a mongocxx::instance must be created before using the driver and
    // must remain alive for as long as the driver is in use.
    //mongocxx::instance m_inst{bsoncxx::stdx::make_unique<logger>(&std::cout)};
    mongocxx::instance inst{bsoncxx::stdx::make_unique<logger>(&std::cout)};
}

Mongo::~Mongo()
{}

#if 0
int64_t Mongo::connect(void)
{
    using bsoncxx::builder::basic::kvp;
    using bsoncxx::builder::basic::make_document;
    using bsoncxx::to_json;

    qDebug() << "Mongo::connect() +" << endl;

    // The mongocxx::instance constructor and destructor initialize and shut down the driver,
    // respectively. Therefore, a mongocxx::instance must be created before using the driver and
    // must remain alive for as long as the driver is in use.

    mongocxx::instance inst{bsoncxx::stdx::make_unique<logger>(&std::cout)};
/*
    auto get_results = [](cursor&& cursor) {
        std::vector<bsoncxx::document::value> results;
        std::transform(cursor.begin(),
                       cursor.end(),
                       std::back_inserter(results),
                       [](bsoncxx::document::view v) { return bsoncxx::document::value{v}; });
        return results;
    };
*/
    try {
        const auto uri = mongocxx::uri{/*(argc >= 2) ? argv[1] : */mongocxx::uri::k_default_uri};

        mongocxx::options::client client_options;
        if (uri.ssl()) {
            mongocxx::options::ssl ssl_options;
            // NOTE: To test SSL, you may need to set options.
            //
            // If the server certificate is not signed by a well-known CA,
            // you can set a custom CA file with the `ca_file` option.
            // ssl_options.ca_file("/path/to/custom/cert.pem");
            //
            // If you want to disable certificate verification, you
            // can set the `allow_invalid_certificates` option.
            // ssl_options.allow_invalid_certificates(true);
            client_options.ssl_opts(ssl_options);
        }
        // the standard mongocxx:client is not thread-safe
        // ( https://stackoverflow.com/a/41250796 )
        auto client = mongocxx::client{uri, client_options};
        // db name
        //auto admin = client["admin"];
        //auto result = admin.run_command(make_document(kvp("isMaster", 1)));

        auto admin = client["testdb"];
        auto col1 = admin["testcollection"];
        auto cursor = col1.find({});
        //auto find_opts = options::find{}.return_key(true);
        //auto cursor = coll.find(doc.view(), find_opts);
        std::size_t i = 0;
        for (auto&& x : cursor) {
            i++;
            qDebug() << "cursor " << i << " : " << x["hello"].length() << endl << endl;
            std::cout << bsoncxx::to_json(x) << "\n";
        }
        QDateTime ts;
        qDebug() << "retrieve - " << ts.toTime_t() << endl << endl;
        return EXIT_SUCCESS;

    } catch (const std::exception& xcp) {
        std::cout << "connection failed: " << xcp.what() << "\n";
        return EXIT_FAILURE;
    }
}
#endif

#if 1
int64_t Mongo::connect(void)
{
    using bsoncxx::builder::basic::kvp;
    using bsoncxx::builder::basic::make_document;
    using bsoncxx::to_json;

    qDebug() << "Mongo::connect() +" << endl;

    // The mongocxx::instance constructor and destructor initialize and shut down the driver,
    // respectively. Therefore, a mongocxx::instance must be created before using the driver and
    // must remain alive for as long as the driver is in use.
#if 1
    mongocxx::instance inst{bsoncxx::stdx::make_unique<logger>(&std::cout)};
#endif
/*
    auto get_results = [](cursor&& cursor) {
        std::vector<bsoncxx::document::value> results;
        std::transform(cursor.begin(),
                       cursor.end(),
                       std::back_inserter(results),
                       [](bsoncxx::document::view v) { return bsoncxx::document::value{v}; });
        return results;
    };
*/
    try {
        const auto uri = mongocxx::uri{mongocxx::uri::k_default_uri};

        mongocxx::options::client client_options;
        if (uri.ssl()) {
            mongocxx::options::ssl ssl_options;
            // NOTE: To test SSL, you may need to set options.
            //
            // If the server certificate is not signed by a well-known CA,
            // you can set a custom CA file with the `ca_file` option.
            // ssl_options.ca_file("/path/to/custom/cert.pem");
            //
            // If you want to disable certificate verification, you
            // can set the `allow_invalid_certificates` option.
            // ssl_options.allow_invalid_certificates(true);
            client_options.ssl_opts(ssl_options);
        }
        // the standard mongocxx:client is not thread-safe
        // ( https://stackoverflow.com/a/41250796 )
        auto client = mongocxx::client{uri, client_options};
        // db name
        //auto admin = client["admin"];
        //auto result = admin.run_command(make_document(kvp("isMaster", 1)));

        auto admin = client["testdb"];
        auto col1 = admin["testcollection"];
        auto cursor = col1.find({});
        //auto find_opts = options::find{}.return_key(true);
        //auto cursor = coll.find(doc.view(), find_opts);
        std::size_t i = 0;
        for (auto&& x : cursor) {
            i++;
            qDebug() << "cursor " << i << " : " << x["hello"].length() << endl;
            std::cout << bsoncxx::to_json(x) << "\n";
        }
        QDateTime ts;
        qDebug() << "timestamp" << ts.toTime_t() << endl;
        return EXIT_SUCCESS;

    } catch (const std::exception& xcp) {
        std::cout << "connection failed: " << xcp.what() << "\n";
        return EXIT_FAILURE;
    }
}
#endif
//  the recommended way to use mongocxx
//  if you're in a multithreaded application
// ( https://stackoverflow.com/a/41250796 )
int64_t Mongo::connectPool(void)
{
    qDebug() << "Mongo::connectPool() +" << endl;
    return 0;
}

int64_t Mongo::disconnect(void)
{
    return 0;
}

// example: https://goo.gl/KGyext
int64_t Mongo::create(Info* p_info)
{
    //qDebug() << "Mongo::create() +" << p_info->speed <<  endl;

    using bsoncxx::builder::basic::kvp;
    using bsoncxx::builder::basic::make_document;
    using bsoncxx::to_json;
    using bsoncxx::builder::stream::document;
    using bsoncxx::builder::stream::close_array;

    try {
#if defined( WRITE2_DB_ )
        //const auto uri = mongocxx::uri{mongocxx::uri::k_default_uri};
        //const auto uri = mongocxx::uri{"mongodb://172.16.0.186:27017"};
        //const auto uri = mongocxx::uri{"mongodb://" + m_host};
        //const auto uri = mongocxx::uri{"mongodb://root:123456@" + m_host + ":" + std::to_string(m_port) + "/?authMechanism=SCRAM-SHA-1"};
        //uri{"mongodb://user1:pwd1@host1/?authSource=db1&authMechanism=SCRAM-SHA-1"}};
        //const auto uri = mongocxx::uri{"mongodb://root:123456@" + m_host + ":" + std::to_string(m_port) + "/?authSource=racev&authMechanism=SCRAM-SHA-1"}; //FIXME:
        //qDebug() << "uri " << QString::fromStdString(uri.to_string()) << endl;
        //const auto uri = mongocxx::uri{"mongodb://" + m_user + ":" + m_pass + "@" + m_host + ":" + std::to_string(m_port) + "/?authMechanism=SCRAM-SHA-1"};
        m_uri = mongocxx::uri("mongodb://" + m_user + ":" + m_pass + "@" + m_host + ":" + std::to_string(m_port) + "/?authMechanism=SCRAM-SHA-1");

        //mongocxx::client client(uri);
        mongocxx::options::client client_options;
        if (m_uri.ssl()) {
            qDebug() << "uri ssl" << endl;
            mongocxx::options::ssl ssl_options;
            client_options.ssl_opts(ssl_options);
        }
        auto client = mongocxx::client{m_uri, client_options};
        //auto admin = client["racev"];
        //auto col1 = admin["car_0001"];
        auto admin = client[m_db];
        auto col1 = admin[m_collection];
        QDateTime current_dt;
        qint64 ts = current_dt.currentSecsSinceEpoch();
#if 0
        qDebug() << "timestamp:" << ts <<
            "host" << QString::fromStdString(m_host) <<
            "db" << QString::fromStdString(m_db) <<
            "collection" << QString::fromStdString(m_collection) << endl;
#endif
        auto builder = bsoncxx::builder::stream::document{};
        bsoncxx::document::value doc_value = builder
          << "name" << "MongoDB"
          << "type" << "database"
          << "count" << 1
          << "versions" << bsoncxx::builder::stream::open_array
            << "v3.2" << "v3.0" << "v2.6"
          << close_array
          << "info" << bsoncxx::builder::stream::open_document
            << "x" << 203
            << "y" << 102
            << "ts" << std::to_string(ts)
            << "speed" << std::to_string(p_info->m_speed)
            << "unit" << p_info->unit
            << "rpm" << std::to_string(p_info->rpm)
            << "rpm_unit" << p_info->rpm_unit
          << bsoncxx::builder::stream::close_document
          << bsoncxx::builder::stream::finalize;

        col1.insert_one(doc_value.view());
#endif
        //qDebug() << "Mongo::create() " << col1.insert_one(doc_value.view()) << endl;
        return EXIT_SUCCESS;
    } catch (const std::exception& xcp) {
        std::cout << "connection failed: " << xcp.what() << "\n";
        return EXIT_FAILURE;
    }
}

int64_t Mongo::createDoc(Info* p_info, string& to_doc)
{
    //qDebug() << "Mongo::createDoc() +" <<  endl;

    using bsoncxx::builder::basic::kvp;
    using bsoncxx::builder::basic::make_document;
    using bsoncxx::to_json;
    using bsoncxx::builder::stream::document;
    using bsoncxx::builder::stream::close_array;

    try {
#if defined( WRITE2_DB_ )
        m_uri = mongocxx::uri("mongodb://" + m_user + ":" + m_pass + "@" + m_host + ":" + std::to_string(m_port) + "/?authMechanism=SCRAM-SHA-1");
        mongocxx::options::client client_options;
        if (m_uri.ssl()) {
            qDebug() << "uri ssl" << endl;
            mongocxx::options::ssl ssl_options;
            client_options.ssl_opts(ssl_options);
        }
        m_client = mongocxx::client{m_uri, client_options};
        auto admin = m_client[m_db];
        auto col1 = admin[to_doc];
        QDateTime current_dt;
        qint64 ts = current_dt.currentSecsSinceEpoch();
#if 0
        qDebug() << "timestamp:" << ts <<
            "host" << QString::fromStdString(m_host) <<
            "db" << QString::fromStdString(m_db) <<
            "collection" << QString::fromStdString(m_collection) << endl;
#endif
        auto builder = bsoncxx::builder::stream::document{};
        bsoncxx::document::value doc_value = builder
          << "name" << "MongoDB"
          << "type" << "database"
          << "count" << 1
          << "versions" << bsoncxx::builder::stream::open_array
            << "v3.2" << "v3.0" << "v2.6"
          << close_array
          << "info" << bsoncxx::builder::stream::open_document
            << "x" << 203
            << "y" << 102
            << "ts" << std::to_string(ts)
            << "speed" << std::to_string(p_info->m_speed)
            << "unit" << p_info->unit
            << "rpm" << std::to_string(p_info->rpm)
            << "rpm_unit" << p_info->rpm_unit
          << bsoncxx::builder::stream::close_document
          << bsoncxx::builder::stream::finalize;

        col1.insert_one(doc_value.view());
#endif
        //qDebug() << "Mongo::create() " << col1.insert_one(doc_value.view()) << endl;
        return EXIT_SUCCESS;
    } catch (const std::exception& xcp) {
        std::cout << "connection failed: " << xcp.what() << "\n";
        return EXIT_FAILURE;
    }
}
