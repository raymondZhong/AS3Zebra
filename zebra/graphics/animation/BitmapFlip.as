package zebra.graphics.animation 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;

	
	
	public class BitmapFlip extends Sprite
	{
		
		private var fLen:Number=400;
		
		
		private var container:Sprite = new  Sprite();
		private var spSide0:Sprite=new Sprite();
		private  var spSide1:Sprite=new Sprite(); 
		
		private var picWidth:Number;

		private var picHeight:Number;
		public  var isMoving:Boolean = false;
		
		private var firstSlices:Array=[]; 
		
		private var secondSlices:Array=[];
			
		private var sliceWidth:Number=1;
		
		private var numSlices:Number;
       
		private var bdFirst:BitmapData;

		private var bdSecond:BitmapData;
		
		private var curTheta:Number=0;
		
		
		
		public function BitmapFlip($w:Number, $h:Number,first:BitmapData=null,second:BitmapData=null)
		{
			
			
			picWidth = $w;
			picHeight = $h;
			numSlices = picWidth / sliceWidth;
			
			container.x = $w / 2;
			container.y = $h / 2;
			addChild(container)
			container.addChild(spSide0);
			container.addChild(spSide1);
			bdFirst = new BitmapData($w, $h);
			bdSecond = new BitmapData($w, $h);
			if(first)bdFirst = first;
			if(second)bdSecond = second;
			
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeFromStageHandler)
			cutSlices();
			renderView(curTheta);
		
		}
		
		private function removeFromStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			removeEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function cutSlices():void {
	
			var i:int;
			
			for(i=0;i<numSlices-1;i++){
				
				firstSlices[i]=new Bitmap(new BitmapData(sliceWidth+1,picHeight));
				
				firstSlices[i].bitmapData.copyPixels(bdFirst,new Rectangle(i*sliceWidth,0,sliceWidth+1,picHeight),new Point(0,0));
				
				secondSlices[i]=new Bitmap(new BitmapData(sliceWidth+1,picHeight));
				
				secondSlices[i].bitmapData.copyPixels(bdSecond,new Rectangle(i*sliceWidth,0,sliceWidth+1,picHeight),new Point(0,0));
				
				spSide0.addChild(firstSlices[i]);
				
				spSide1.addChild(secondSlices[i]);
			}
			
			firstSlices[numSlices-1]=new Bitmap(new BitmapData(sliceWidth,picHeight));
				
			firstSlices[numSlices-1].bitmapData.copyPixels(bdFirst,new Rectangle((numSlices-1)*sliceWidth,0,sliceWidth,picHeight),new Point(0,0));
				
			secondSlices[numSlices-1]=new Bitmap(new BitmapData(sliceWidth,picHeight));
				
			secondSlices[numSlices-1].bitmapData.copyPixels(bdSecond,new Rectangle((numSlices-1)*sliceWidth,0,sliceWidth,picHeight),new Point(0,0));
				
			spSide0.addChild(firstSlices[numSlices-1]);
				
			spSide1.addChild(secondSlices[numSlices-1]);
		}
		
		
		private function renderView(t:Number):void {

				var j:int;

				var curv0:Array=[];
				
				var curv1:Array=[];
				
				var curv2:Array=[];
				
				var curv3:Array=[];
				
				var curNormal:Number;
				
				var factor1:Number;
				
				var factor2:Number;
				
				var curTransMatrix:Matrix;
				
				t=t*Math.PI/180;
				
				curNormal=Math.cos(t);
				
				if(curNormal>=0){
					
					for(j=0;j<numSlices;j++){
						
						firstSlices[j].visible=true;
						
						secondSlices[j].visible=false;
						
					}
				
				} else {
					
					for(j=0;j<numSlices;j++){
						
						firstSlices[j].visible=false;
						
						secondSlices[j].visible=true;
						
					}
				}
				
				for(j=0;j<numSlices;j++){
					
						factor1=fLen/(fLen-Math.sin(t)*(-picWidth/2+j*sliceWidth));
						
						factor2=fLen/(fLen-Math.sin(t)*(-picWidth/2+(j+1)*sliceWidth));
						
						curv0=[factor1*(-picWidth/2+j*sliceWidth)*Math.cos(t),-factor1*picHeight/2];
						
						curv1=[factor2*(-picWidth/2+(j+1)*sliceWidth)*Math.cos(t),-factor2*picHeight/2];
					
						curv2=[factor2*(-picWidth/2+(j+1)*sliceWidth)*Math.cos(t),factor2*picHeight/2];
					
						curv3=[factor1*(-picWidth/2+j*sliceWidth)*Math.cos(t),factor1*picHeight/2];
					
						curTransMatrix=calcMatrixForSides(curv0,curv1,curv2,curv3);
					
						firstSlices[j].transform.matrix=curTransMatrix;
						
				}
						
					for(j=0;j<numSlices;j++){
						
						factor1=fLen/(fLen-Math.sin(t)*(picWidth/2-j*sliceWidth));
						
						factor2=fLen/(fLen-Math.sin(t)*(picWidth/2-(j+1)*sliceWidth));
					
						curv0=[factor1*(picWidth/2-j*sliceWidth)*Math.cos(t),-factor1*picHeight/2];
						
						curv1=[factor2*(picWidth/2-(j+1)*sliceWidth)*Math.cos(t),-factor2*picHeight/2];
					
						curv2=[factor2*(picWidth/2-(j+1)*sliceWidth)*Math.cos(t),factor2*picHeight/2];
					
						curv3=[factor1*(picWidth/2-j*sliceWidth)*Math.cos(t),factor1*picHeight/2];
					
						curTransMatrix=calcMatrixForSides(curv0,curv1,curv2,curv3);
					
						secondSlices[j].transform.matrix=curTransMatrix;
				}
				
			}
			
		private function calcMatrixForSides(v0:Array,v1:Array,v2:Array,v3:Array):Matrix {
			var curMatrix:Matrix;
			var transMatrix:Matrix;
			var v:Array=findVecMinusVec(v1,v0);
			var w:Array=findVecMinusVec(v3,v0);
			curMatrix=new Matrix(v[0]/sliceWidth,v[1]/sliceWidth,w[0]/picHeight,w[1]/picHeight);
			transMatrix=new Matrix(1,0,0,1,v0[0],v0[1]);
			curMatrix.concat(transMatrix);
			return curMatrix;			
		}
	
		private function findVecMinusVec(v:Array,w:Array):Array {
			return [v[0]-w[0],v[1]-w[1],v[2]-w[2]];
		}	
		
		
		private function onEnter(e:Event): void {			
			if(isMoving){				
				curTheta+=36/2;				
				curTheta=curTheta%360;						
				renderView(curTheta);				
				if((curTheta%180)==0){					
					isMoving=false;					
				}
			}
		}
		
		
		public function setImage(first:BitmapData, second:BitmapData):void {
			   spSide0.removeChildren();
			   spSide1.removeChildren();
			   bdFirst = first;
			   bdSecond = second;
			   cutSlices();
			   renderView(curTheta);
			}
		
		public function setFirst(first:BitmapData):void {
			   spSide0.removeChildren();
			   bdFirst = first;
			   cutSlices();
			   renderView(curTheta);
			}
			
		public function setSecond(second:BitmapData):void {			
			   spSide1.removeChildren();
			   bdSecond = second;
			   cutSlices();
			   renderView(curTheta);
			}
			
			
		public function setCurrentBack(bd:BitmapData):void {
			  
			if (!isMoving && curTheta == 180) {
				spSide0.removeChildren();
			    spSide1.removeChildren();
				setFirst(bd)
			}
			if (!isMoving && curTheta == 0) {
				spSide0.removeChildren();
			    spSide1.removeChildren();
				setSecond(bd)
			}
		}	
			
			
		public function trigger():void {
			if(isMoving==false){	
				isMoving=true;				
			  }
		}	
		
	}

}