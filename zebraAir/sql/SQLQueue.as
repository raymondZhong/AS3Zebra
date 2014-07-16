package zebraAir.sql 
{ 
	import acheGesture.core.PropGesture;
	import flash.data.SQLStatement;
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	public class SQLQueue 
	{
		
		protected var sqlQueue:Vector.<SQLStatement>;
		protected var currentCommandLine:int = 0;		
		protected var sqlConn:SQLConnection;
		
		public var  errorHandler:Function;
		public var  successHandler:Function;
		
		public function SQLQueue() 
		{
			this.sqlQueue = new Vector.<SQLStatement>();
			sqlConn = new SQLConnection();
			sqlConn.addEventListener(SQLEvent.OPEN, openHandler);					
		}
		
		private function openHandler(event:SQLEvent):void
		{ 
			sqlConn.addEventListener(SQLEvent.BEGIN, beginHandler);
            sqlConn.begin();
		}
		
		private function beginHandler(e:SQLEvent):void 
		{
			if(sqlQueue.length>0)
			sqlQueue[0].execute();
		}		
		
		/**
		 * 执行事务语句  设置数据库并且异步打开
		 */
		public function execute():void {
			    //var dbFile:File = File.applicationDirectory.resolvePath("db/navigationDB");
			    //sqlConn.openAsync(dbFile);
			}
			
		/**
		 * 添加SQL语句  String or SQLStatement
		 * @param	sql
		 * @return
		 */	
		public function appendSQL(sql:Object):SQLStatement {
			var s:SQLStatement = new SQLStatement()
			if (sql is SQLStatement) {
				  s = SQLStatement(sql);
				  s.sqlConnection = sqlConn;
				}else {
				    s.sqlConnection = sqlConn;
					s.text = String(sql);	
				}
			s.addEventListener(SQLEvent.RESULT, successSQLChild);
			s.addEventListener(SQLErrorEvent.ERROR, error);			
			sqlQueue.push(s);
			return s;
		}
		

			 
		
		//每个sql语句成功
		protected function successSQLChild(e:SQLEvent):void 
		{
				currentCommandLine++;
				if (currentCommandLine == sqlQueue.length) {
						 success(null);
					}else {
					sqlQueue[currentCommandLine].execute();	
					}
		}
		
		//执行回滚结束
		private function rollbackHandler(e:SQLEvent):void 
		{
             sqlConn.removeEventListener(SQLEvent.ROLLBACK, rollbackHandler);			 
			 
			trace("transaction error 事务出错.进行了回滚")
			if (errorHandler) errorHandler(e);
		}
		
		
		//出错事务回滚
		protected function error(e:SQLErrorEvent):void 
		{
			if (sqlConn.inTransaction)
				{
					sqlConn.addEventListener(SQLEvent.ROLLBACK, rollbackHandler);
					sqlConn.rollback();
				}	
		}
		
		//数据语句操作成功,提交事务过程
		protected function success(e:SQLEvent):void 
		{
			sqlConn.addEventListener(SQLEvent.COMMIT, commitHandler);
			sqlConn.commit(); //所有sql都通过执行,在提交整个事务,进行操作.
			
		}	
		
		//事务提交成功调用回调函数 
        private function commitHandler(e:SQLEvent):void
        {
            sqlConn.removeEventListener(SQLEvent.COMMIT, commitHandler);
			if (successHandler) successHandler(e);
        }	
		
	}

}