#include "sqlite3.h"
#include <stdio.h>
#include <iostream>

int main()
{
    sqlite3 *db=NULL;
    char **azResult;
    char *zErrMsg;
    int nrow=0, ncolumn=0,rc;
    char const *db_name="test.db";
    char sql[1024];
    rc=sqlite3_open(db_name,&db);
    if(!rc){
        std::cout << "db open ok" << std::endl;
        rc=sqlite3_exec(db,"CREATE TABLE IF NOT EXISTS test (test_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, test INTEGER)",NULL,NULL,&zErrMsg);
        if(!rc){
            std::cout << "create ok" << std::endl;
            for(int i=0;i<256;i++){
                sprintf(sql,"insert into test values (NULL,%d)",i);
                std::cout << sql << std::endl;
                rc=sqlite3_exec(db,sql,NULL,NULL,&zErrMsg);
                if(rc)
                {
                    std::cout << "insert exec failed" << std::endl;
                    break;
                }
            }
            rc=sqlite3_get_table(db,"select * from test",&azResult,&nrow,&ncolumn,&zErrMsg);
            if(zErrMsg!=0){
                std::cout << "" << zErrMsg << std::endl;
                sqlite3_free(zErrMsg);
                std::cout << "get table failed" << std::endl;
                return -1;
            }else{
                for(int i=1;i<(nrow+1);i++)
                    std::cout << azResult[i*ncolumn+0] << "," << azResult[i*ncolumn+1] <<std::endl;
                sqlite3_exec(db,"drop table test",NULL,NULL,&zErrMsg);
                std::cout << "db drop ok" << std::endl;
                return 0;
            }
        }else{
            std::cout << "create table failed" << std::endl;
            return 2;
        }
    }else{
        std::cout << "db open failed" << std::endl;
        return 1;
    }
}
