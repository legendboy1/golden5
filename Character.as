class Character{
	public var id:Number;
	public var x:Number;
	public var y:Number;
	public var px:Number;
	public var py:Number;
	public var vx:Number;
	public var vy:Number;
	public var onob:Boolean;
	public var dire:Number;
	public var carry:Boolean;
	public var carryObject:Number;
	public var carriedBy:Number;
	public var landTimer:Number;
	public var deathTimer:Number;
	public var charState:Number;
	public var standingOn:Number;
	public var stoodOnBy:Array;
	public var w:Number;
	public var h:Number;
	public var weight:Number;
	public var weight2:Number;
	public var h2:Number;
	public var atEnd:Boolean;
	public var friction:Number;
	public var fricGoal:Number;
	public var justChanged:Number;
	public var speed:Number;
	public var buttonsPressed:Array;
	public var pcharState:Number;
	public var submerged:Number;
	public var temp:Number;
	public var heated:Number;
	public var heatSpeed:Number;
	public var explosionTimer:Number;
	public var explosionChange:Boolean;
	public var origExplosionTimer:Number;
	public var automaticNPCandRotatingTimer:Number;
	public var automaticNPCState:Number;
	public var framesOrDegreesTraveled:Number;
	public var startPosIndex:Number;
	public var rotation:Number;
	public var pRotation:Number;
	public var climbing:Boolean;
	public var doubleJump:Boolean;
	public var shrink:Boolean;
	public var shrinking:Boolean;
	public var kicked:Boolean;
	public var kickTimer:Number;
	public var jetFuel:Number;
	public var skateboard:Number;
	public var skater:Number;
	public function Character(tid:Number,tx:Number, ty:Number, tpx:Number, tpy:Number, tvx:Number, tvy:Number, tonob:Boolean,
	tdire:Number,tcarry:Boolean, tcarryObject:Number, tcarriedBy:Number, tlandTimer:Number, tdeathTimer:Number,tcharState:Number,
	tstandingOn:Number, tstoodOnBy:Array, tw:Number, th:Number, tweight:Number, tweight2:Number, th2:Number,
	tatEnd:Boolean, tfriction:Number, tfricGoal:Number, tjustChanged:Number,tspeed:Number,tbuttonsPressed:Array, tpcharState:Number,
	tsubmerged:Number, ttemp:Number, theated:Number,theatSpeed:Number, texplosionTimer:Number, texplosionChange:Boolean, torigExplosionTimer:Number, 
	tautomaticNPCandRotatingTimer:Number, tautomaticNPCState:Number, tframesOrDegreesTraveled:Number, tstartPosIndex:Number, trotation:Number, tpRotation:Number, 
	tclimbing:Boolean, tdoubleJump:Boolean, tshrink:Boolean, tshrinking:Boolean, tkicked:Boolean,tkickTimer:Number,tjetFuel:Number,tskateboard:Number,tskater:Number){
		id = tid;
		x = tx;
		y = ty;
		px = tx;
		py = ty;
		vx = tvx;
		vy = tvy;
		onob = tonob;
		dire = tdire;
		carry = tcarry;
		carryObject = tcarryObject;
		carriedBy = tcarriedBy;
		landTimer = tlandTimer;
		deathTimer = tdeathTimer;
		charState = tcharState;
		standingOn = tstandingOn;
		stoodOnBy = tstoodOnBy;
		w = tw;
		h = th;
		weight = tweight;
		weight2 = tweight2;
		h2 = th2;
		atEnd = tatEnd;
		friction = tfriction;
		fricGoal = tfricGoal;
		justChanged = tjustChanged;
		speed = tspeed;
		buttonsPressed = tbuttonsPressed;
		pcharState = tpcharState;
		submerged = tsubmerged;
		temp = ttemp;
		heated = theated;
		heatSpeed = theatSpeed;
		explosionTimer = texplosionTimer;
		explosionChange = texplosionChange;
		origExplosionTimer = torigExplosionTimer;
		automaticNPCandRotatingTimer = tautomaticNPCandRotatingTimer;
		automaticNPCState = tautomaticNPCState;
		framesOrDegreesTraveled = tframesOrDegreesTraveled;
		startPosIndex = tstartPosIndex;
		rotation = trotation;
		pRotation = tpRotation;
		climbing = tclimbing;
		doubleJump = tdoubleJump;
		shrink = tshrink;
		shrinking = tshrinking;
		kicked = tkicked;
		kickTimer = tkickTimer;
		jetFuel = tjetFuel;
		skateboard = tskateboard;
		skater = tskater;
	}
	function applyForces(grav:Number, control:Boolean,waterUpMaxSpeed:Number){
		var gravity:Number;
		if(grav >= 0) gravity = Math.sqrt(grav);
		if(grav < 0) gravity = -Math.sqrt(-grav);
		if(!onob && submerged != 1 && !climbing) vy = Math.min(vy+gravity,25);
		if(onob || control || charState == 12 || skater > -1){
			vx = (vx-fricGoal)*friction+fricGoal;
		}else{
			vx *= 1-(1-friction)*0.12;
		}
		if(Math.abs(vx) < 0.01 || climbing){
			vx = 0;
		}
		if(submerged == 1){
			vy = 0;
			if(weight2 > 0.18) submerged = 2;
		}else if(submerged >= 2){
			if(vx > 1.5) vx = 1.5;
			if(vx < -1.5) vx = -1.5;
			if(vy > 1.8) vy = 1.8;
			if(vy < -waterUpMaxSpeed) vy = -waterUpMaxSpeed;
		}
	}
	function charMove(){
		y += vy;
		x += vx;
	}
	function moveHorizontal(power){
		if(power*fricGoal <= 0 && !onob){
			fricGoal = 0;
		}
		vx += power;
		if(power < 0) dire = 1;
		if(power > 0) dire = 3;
		justChanged = 2;
		
	}
	function stopMoving(){
		if(dire == 1) dire = 2;
		if(dire == 3) dire = 4;
	}
	function jump(jumpPower:Number){
		if(shrink) vy = jumpPower/1.2;
		else vy = jumpPower;
	}
	function swimUp(jumpPower:Number){
		vy -= weight2+jumpPower;
	}
}